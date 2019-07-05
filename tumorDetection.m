function [detection, area] = tumorDetection(image, threshold)
% function [detection, area] = tumorDetection(image, threshold)

% Sejal Dua
% 5/10/2018

    %% EDGE SEGMENTATION AND TUMOR RECOGNITION
    bw = im2bw(image, 0.7);
    label = bwlabel(bw);

    % solidity: proportion of the pixels in the convex hull that are also in the region (Area/ConvexArea).
    stats = regionprops(label, 'Solidity','Area'); 
    density = [stats.Solidity];
    area = [stats.Area];
    
    % sets a threshold for density (0.5 is a pretty dense tumor) and extracts the region of highest density
    highDensityArea = density > threshold; 
    if highDensityArea == 0
            message = sprintf('No tumors were detected with this threshold');
            h = msgbox(message);
            pause(1);
            close(h);
            close all;
            detection = 0;
            return
    elseif isempty(highDensityArea)
            message = sprintf('No tumors were detected with this threshold');
            h = msgbox(message);
            pause(1);
            close(h);
            close all;
            detection = 0;
            return
    end
    
    % defines the tumor as the area of highest density
    maxArea = max(area(highDensityArea));
    tumorLabel = find(area == maxArea);
    tumor = ismember(label, tumorLabel);
    
    % creates a square structuring element 5 pixels wide x 5 pixels long
    se = strel('square',5);
    
    % dilates the binary image within the square structuring element
    tumor = imdilate(tumor, se);
    
    
    %% TUMOR AREA INFORMATION
    areaTumor = length(find(tumor == 1));
    if (ndims(image) == 3)
        convertedImg = rgb2gray(image);
        areaBrain = length(find(convertedImg ~= 0));
    else
        areaBrain = length(find(image ~= 0));
    end
   areaRatio = areaTumor / areaBrain;
   area = struct('areaTumor', areaTumor, 'areaBrain', areaBrain, 'areaRatio', areaRatio);
   
        
    %% PLOTTING
    % plots original brain MRI scan
    figure;
    subplot(1, 3, 1);
    imshow(image);
    title('Brain MRI');

    % plots the segmented tumor image alone
    subplot(1, 3, 2);
    imshow(tumor);
    title('Tumor Alone');
    [B, ~] = bwboundaries(tumor, 'noholes');
    
    % overlays the edges of the detected tumor on top of the original MRI scan
    subplot(1, 3, 3);
    imshow(image);
    hold on
    for i = 1 : length(B)
        plot(B{i}(:, 2), B{i}(:, 1), 'y', 'LineWidth', 1.5);
    end
    title('Detected Tumor');
    hold off;
    
    %% USER EVALUATION
    % asks the user to evaluate the accuracy of the tumor detection
    true = 1;
    while(true)
        choice = input('Is the detected tumor correct? (hit enter for correct, "n" key for incorrect)', 's');
        if isempty(choice)
            detection = 1;
            close all;
            true = 0;
        elseif (strcmp(choice, 'n'))
            detection = 0;
            close all;
            true = 0;
        else
            fprintf('Please hit enter or n to indicate correct or not correct, respectively\n');
        end
    end
    
    
return
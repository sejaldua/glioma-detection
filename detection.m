clear;
close all;


load inputData.mat
figure;
for i = 1 : length(img)
    subplot(3, 5, i);
    imshow(img{i});
    if (knownClassification(i) == 1)
        title('benign');
    elseif (knownClassification(i) == 2)
        title('malignant');
    elseif (knownClassification(i) == 0)
        title('no tumor');
    end
end
saveas(gcf, 'inputImages.jpg');
fprintf('First take a look at the data!\n');
    
thresholds = 0.1 : 0.1 : 0.9;
isDetected = cell(1, length(img));
tumorStats = cell(1, length(img));
for k = 1 : length(img)
    for l = 1 : length(thresholds)
        [isDetected{k}(l), area] = tumorDetection(img{k}, thresholds(l));
        if (isDetected{k}(l) == 1)
            tumorStats{k}(l) = area;
            bestIndex = l;
        else
            tumorStats{k}(l) = struct('areaTumor', 0, 'areaBrain', 0, 'areaRatio', 0);
        end
    end
    tumorStats{k} = tumorStats{k}(bestIndex);
end
save('detection.mat', 'isDetected', 'knownClassification', 'thresholds', 'tumorStats');
tumorStatsFileWrite(tumorStats, knownClassification);
function [lb,center] = clusteringAlgo(im)
% function [lb, center] = clusteringAlgo(im)
% input
    % im - input image to be clustered
% outputs
    % lb - labeled image / clustered image
    % center - array of cluster centers.

    im = double(im);
    red = im(:,:,1); 
    green = im(:,:,2); 
    blue = im(:,:,3);

    array = [red(:),green(:),blue(:)];
    i = 0;
    j=0;
    tic
    while(true)
        seed(1) = mean(array(:,1));
        seed(2) = mean(array(:,2));
        seed(3) = mean(array(:,3));
        i = i+1;
        while(true)
            j = j+1;
            seedvec = repmat(seed, [size(array, 1), 1]);
            dist = sum((sqrt((array-seedvec).^2)),2);
            distThresh = 0.25 * max(dist);
            qualified = dist < distThresh;
            newred = array(:,1);
            newgreen = array(:,2);
            newblue = array(:,3);
            
            newseed(1) = mean(newred(qualified));
            newseed(2) = mean(newgreen(qualified));
            newseed(3) = mean(newblue(qualified));
            
            if isnan(newseed)
                break;
            end

            if (seed == newseed) | j>10
                j=0;
                array(qualified,:) = [];
                center(i,:) = newseed;
                break;
            end
            seed = newseed;
        end

        if isempty(array) || i>10
            i = 0;
            break;
        end

    end
    toc
    centers = sqrt(sum((center.^2),2));
    [centers,idx]= sort(centers);


    while(true)
    newcenter = diff(centers);
    intercluster =25; 
    a = (newcenter<=intercluster);
    centers(a,:) = [];
    idx(a,:)=[];
    if nnz(a)==0
        break;
    end

    end
    center1 = center;
    center = center1(idx,:);
    
    vecred = repmat(red(:),[1,size(center,1)]);
    vecgreen = repmat(green(:),[1,size(center,1)]);
    vecblue = repmat(blue(:),[1,size(center,1)]);

    distred = (vecred - repmat(center(:,1)',[numel(red),1])).^2;
    distgreen = (vecgreen - repmat(center(:,2)',[numel(red),1])).^2;
    distblue = (vecblue - repmat(center(:,3)',[numel(red),1])).^2;

    distance = sqrt(distred+distgreen+distblue);
    [~,label_vector] = min(distance,[],2);
    lb = reshape(label_vector,size(red));
    
    for i = 1: length(center)
        subplot(1, length(center), i);
        imshow(lb == i)
    end
    
    
return
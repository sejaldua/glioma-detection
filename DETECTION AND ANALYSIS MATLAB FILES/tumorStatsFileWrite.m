function tumorStatsFileWrite(tumorStats, knownClassification)
% function tumorStatsFileWrite(tumorStats, knownClassification)

% Sejal Dua
% 5/10/2018
    
    % turns numbers in knownClassification to strings so that the user can understand the tumor classification
    classification = cell(1, length(knownClassification));
    for i = 1 : length(knownClassification)
        if (knownClassification(i) == 0)
            classification{i} = 'no tumor';
        elseif(knownClassification(i) == 1)
            classification{i} = 'benign';
        elseif(knownClassification(i) == 2)
            classification{i} = 'malignant';
        end
    end
    
    for i = 1:length(tumorStats)
        tumor(i) = tumorStats{i}.areaTumor;
    end
    
     for i = 1:length(tumorStats)
        brain(i) = tumorStats{i}.areaBrain;
     end
    
      for i = 1:length(tumorStats)
        ratio(i) = round(tumorStats{i}.areaRatio, 2);
      end
    

    T = table((1:1:length(knownClassification))', classification', tumor', brain', ratio');
    T.Properties.VariableNames = {'ImageNum' 'Classification' 'TumorArea' 'BrainArea', 'AreaRatio'};
    writetable(T, 'tumorStats.txt', 'Delimiter', '\t');

    
    fid = fopen('tumorStats.txt','at');
    assert(fid>0,'file open error')
    
    % write a header (descriptor) line
    fprintf(fid,'\n\nTumor Statistics by Classification\n');  

    noTumorIndices = find(knownClassification == 0);
    for i = 1 : length(noTumorIndices)
        aRatio(i) = tumorStats{noTumorIndices(i)}.areaRatio;
    end
     meanRatio0 = mean(aRatio);
     percent0 = round(meanRatio0 * 100, 2);
     
    BTumorIndices = find(knownClassification == 1);
    for i = 1 : length(BTumorIndices)
        aRatio(i) = tumorStats{BTumorIndices(i)}.areaRatio;
    end
     meanRatio1 = mean(aRatio);
     percent1 = round(meanRatio1 * 100, 2);
     
    MTumorIndices = find(knownClassification == 2);
    for i = 1 : length(MTumorIndices)
        aRatio(i) = tumorStats{MTumorIndices(i)}.areaRatio;
    end
     meanRatio2 = mean(aRatio);
     percent2 = round(meanRatio2 * 100, 2);

   fprintf(fid, 'Average area percentage (tumor/ brain) for tumor-free MRI scans from this dataset: %.2f%%\n', percent0);
   fprintf(fid, 'Average area percentage (tumor/ brain) for benign tumor MRI scans from this dataset: %.2f%%\n', percent1);
   fprintf(fid, 'Average area percentage (tumor/ brain) for malignant tumor MRI scans from this dataset: %.2f%%\n', percent2);
   

    fclose(fid);
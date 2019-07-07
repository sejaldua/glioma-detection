function customErrorAnalysis(checkboxValues)

    load detection.mat;
    
    count = 1;
    for i = 1 : length(checkboxValues)
        if (checkboxValues{i} == 1)
            indices(count) = i;
            count = count + 1;
        end
    end
    
    knownClassificationNew = knownClassification(indices);
    isDetectedNew = cell(1, length(indices));
    count = 1;
    for i = 1 : length(isDetected)
        if (i == indices(count))
                isDetectedNew{count} = isDetected{i}(1:end);
                if (count < length(indices))
                    count = count + 1;
                end
        end
    end

    PC = zeros(1, length(thresholds));
    MC = zeros(1, length(thresholds));
    FA = zeros(1, length(thresholds));
    for l = 1 : length(thresholds)
        for k = 1 : length(isDetectedNew)
            % tumor was not presented AND no tumor was detected... yay!
            if (knownClassificationNew(k) == 0 && isDetectedNew{k}(l) == 0)
                PC(l) = PC(l) + 1;
            % tumor was presented AND tumor was detected accurately... yay!
            elseif (knownClassificationNew(k) ~= 0 && isDetectedNew{k}(l) == 1)
                PC(l) = PC(l) + 1;
            % tumor was presented AND tumor was not detected accurately... sad :(
            elseif (knownClassificationNew(k) ~= 0 && isDetectedNew{k}(l) == 0)
                MC(l) = MC(l) + 1;
            % tumor was not presented but a tumor was still detected... yikes :(
            elseif (knownClassificationNew(k) == 0 && isDetectedNew{k}(l) == 1)
                FA(l) = FA(l) + 1;
            end
        end
    end


    %% PERFORMANCE ANALYSIS OF LOGISTIC REGRESSION CLASSIFIER

    PCpct = (PC / length(thresholds)) * 100;
    MCpct = (MC / length(thresholds)) * 100;   
    FApct = (FA / length(thresholds)) * 100;

    PI = zeros(1, length(thresholds));
    sens = zeros(1, length(thresholds));
    spec = zeros(1, length(thresholds));
    accuracy = zeros(1, length(thresholds));
    for k = 1 : length(thresholds)
        PI(k) = ((PC(k) - MC(k) - FA(k)) / PC(k)) * 100;
        sens(k) = (PC(k) / (PC(k) + FA(k))) * 100;
        spec(k) = (PC(k) / (PC(k) + MC(k))) * 100;
        accuracy(k) = (sens(k) + spec(k)) / 2;
    end
    
    save('guiPlotting.mat', 'knownClassificationNew', 'isDetectedNew', 'thresholds', 'PCpct', 'MCpct', 'FApct', 'PI', 'sens', 'spec', 'accuracy');
    
return

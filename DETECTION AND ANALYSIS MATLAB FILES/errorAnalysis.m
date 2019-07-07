load detection.mat;

% 2 forms of logical regression: confusion matrix and 3 variable classification analysis
TP = zeros(1, length(thresholds));
FP = zeros(1, length(thresholds));
TN = zeros(1, length(thresholds));
FN = zeros(1, length(thresholds));
TPR = zeros(1, length(thresholds));
FPR = zeros(1, length(thresholds));

PC = zeros(1, length(thresholds));
MC = zeros(1, length(thresholds));
FA = zeros(1, length(thresholds));
for l = 1 : length(thresholds)
    for k = 1 : length(isDetected)
        % tumor was not presented AND no tumor was detected... yay!
        if (knownClassification(k) == 0 && isDetected{k}(l) == 0)
            TN(l) = TN(l) + 1;
            PC(l) = PC(l) + 1;
        % tumor was presented AND tumor was detected accurately... yay!
        elseif (knownClassification(k) ~= 0 && isDetected{k}(l) == 1)
            TP(l) = TP(l) + 1;
            PC(l) = PC(l) + 1;
        % tumor was presented AND tumor was not detected accurately... sad :(
        elseif (knownClassification(k) ~= 0 && isDetected{k}(l) == 0)
            FN(l) = FN(l) + 1;
            MC(l) = MC(l) + 1;
        % tumor was not presented but a tumor was still detected... yikes :(
        elseif (knownClassification(k) == 0 && isDetected{k}(l) == 1)
            FP(l) = FP(l) + 1;
            FA(l) = FA(l) + 1;
        end
    end
    TPR(l) = TP(l) / (TP(l) + FN(l));          % sensitivity
    FPR(l) = FP(l) / (FP(l) + TN(l));          % 1 - specificity
end


%% MY ATTEMPT AT AN ROC CURVE (BIOSTATS PREDICTION ANALYSIS METHOD)
confusionMat = {TP, FP; FN, TN};
fprintf('true positives');
disp(TP);
fprintf('false positives');
disp(FP);
fprintf('false negatives');
disp(FN);
fprintf('true negatives');
disp(TN);
fprintf('true positive rate');
disp(TPR);
fprintf('false positive rate');
disp(FPR);

figure;
plot(FPR, TPR, 'b');
title('ROC Curve')
xlabel('False Positive Rate')
ylabel('True Positive Rate')
xlim([0, 1]);
ylim([0, 1]);
savefig('roc')

%% MATLAB'S ROC CURVE

% Matlab's ROC curve with my data as input arguments seems to produce
% something meaningful. I'm not too sure what I did wrong. If I had time, I
% would learn more about ROC curves and figure out what I am doing wrong.

 % I also struggled getting perfcurve (a Matlab built-in function) to work
 % for me. 

 figure;
 plotroc(knownClassification(knownClassification ~= 0), isDetected);
 print(gcf, 'roc', '-djpeg')
 

%% PERFORMANCE ANALYSIS OF LOGISTIC REGRESSION CLASSIFIER

PCpercentage = (PC / length(isDetected)) * 100;
MCpercentage = (MC / length(isDetected)) * 100;   
FApercentage = (FA / length(isDetected)) * 100;

h(1) = figure;
plot(thresholds, PCpercentage, 'b')
hold on;
plot(thresholds, MCpercentage, 'r')
plot(thresholds, FApercentage, 'g');
hold off;
title('Performance Analysis of Logistic Regression Classifier for Tumor Detection');
xlabel('Density Threshold');
ylabel('Classification Rates');
legend('Perfect Classification', 'Missed Classification', 'False Alarm',  'Location', 'northwest');

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

h(2) = figure;
plot(thresholds, PI, 'b');
hold on;
plot(thresholds, sens, 'g');
plot(thresholds, spec, 'r');
plot(thresholds, accuracy, 'k');
hold off;
title('Performance Analysis of Logistic Regression Classifier for Tumor Detection');
xlabel('Density Threshold');
ylabel('Performance Analysis Statistics');
legend('Performance Index', 'Sensitivity', 'Specificity', 'Accuracy', 'Location', 'northwest');
savefig(h, 'performanceAnalysis.fig');



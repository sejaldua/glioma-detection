% Sejal Dua
% 5/10/2018

clear;
close all;

% user evaluation of tumor detection accuracy by algorithm
evaluateOption = input('Do you want to evaluate the accuracy of the tumor detection function\n(Enter the "y" key for yes and "n" key for no)\n', 's');
if (strcmp(evaluateOption, 'y'))
    detection;
end

% NOTE: tumorDetection.m is the largest portion of my code and is called by detection.m

% error analysis of algorithm accuracy
errorAnalysis;

% prompt user to interact with GUI
isReady = input('Are you ready to check out my error analysis GUI?\n(Enter "y" for yes whenever you are ready)\n', 's');
if (strcmp(isReady, 'y'))
    errorAnalysisGUI;
end

% lastly, please check out my tumorStats.txt file

fprintf('\n\nThat"s my project! Thank you!\n\n')





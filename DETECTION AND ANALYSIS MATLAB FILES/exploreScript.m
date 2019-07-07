clear
close all

%% Step 1: data read-in
% 'csvread'
% first line in the file is 'line 0'.

inpfile = importdata('oasis_longitudinal.csv');

group = zeros(length(inpfile.textdata)-1, 1);
for i = 2:length(inpfile.textdata)
    if (strcmp(inpfile.textdata{i, 3}, 'Nondemented'))
        group(i-1) = 0;
    elseif (strcmp(inpfile.textdata{i, 3}, 'Converted'))
        group(i-1) = 0.5;
    elseif (strcmp(inpfile.textdata{i, 3}, 'Demented'))
        group(i-1) = 1;
    end
end

visitNum = zeros(length(inpfile.textdata)-1, 1);
for i = 2 : length(inpfile.textdata)
    visitNum(i-1) = inpfile.textdata{i, 4};
end

%MRDelay


gender = zeros(length(inpfile.textdata)-1, 1);
for i = 2:length(inpfile.textdata)
    if (strcmp(inpfile.textdata{i, 6}, 'F'))
        gender(i-1) = 0;
    elseif (strcmp(inpfile.textdata{i, 6}, 'M'))
        gender(i-1) = 1;
    end
end

hand = zeros(length(inpfile.textdata)-1, 1);
for i = 2:length(inpfile.textdata)
    if (strcmp(inpfile.textdata{i, 7}, 'L'))
        hand(i-1) = 0;
    elseif (strcmp(inpfile.textdata{i, 7}, 'R'))
        hand(i-1) = 1;
    end
end

datamat = [group, visitNum, gender, hand, inpfile.data];
%% Step 2

group = datamat(:, 1);
visitNum = datamat(:, 2);
gender = datamat(:, 3);
hand = datamat(:, 4);
age = datamat(:, 5);
educ = datamat(:, 6);
ses = datamat(:, 7);
mmse = datamat(:, 8);
cdr = datamat(:, 9);
etiv = datamat(:, 10);
nwbv = datamat(:, 11);
asf = datamat(:, 12);


%% Step 6: Age vs. smoking.  
% Use boxplots to see if the age of the subject relates to smoking status? 
% Do smokers have a different average age than non-smokers?  You should 
% see that smokers are on average slightly older than non-smokers.  

dementedIndices = find(group == 1);
avgDAge = mean(age(dementedIndices));
nondementedIndices = find(group == 0);
avgNAge = mean(age(nondementedIndices));
convertedIndices = find(group == 0.5);
avgCAge = mean(age(convertedIndices));


figure;
subplot(331);
boxplot(educ, group, 'notch', 'on')

subplot(332);
boxplot(educ, ses, 'notch', 'on')

subplot(333);
boxplot(nwbv, cdr, 'notch', 'on')

subplot(334);
boxplot(mmse, group, 'notch', 'on')

subplot(335);
boxplot(mmse, cdr, 'notch', 'on')

%% deal with converted indices

%{
gscatter(nwbv, age, group)

convertedIndices = find(group == 0.5)
for i = 1 : length(convertedIndices)
    group(convertedIndices(i)) = 1;
end
figure;
gscatter(nwbv, age, group)
%}

%% get rid of converted indices

figure;
trimmedIndices = find(group == 0 | group == 1)
gscatter(nwbv(trimmedIndices), age(trimmedIndices), group(trimmedIndices))

figure;
scatter3(nwbv(find(group == 0)), age(find(group == 0)), mmse(find(group == 0)))
hold on;
scatter3(nwbv(find(group == 1)), age(find(group == 1)), mmse(find(group == 1)))
hold off;
xlabel('nwbv');
ylabel('age');
zlabel('mmse');
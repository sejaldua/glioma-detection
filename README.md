Topic: Automated brain tumor detection and segmentation using threshold density algorithm with logistic regression and ROC error analysis

Author: Sejal Dua
Date: 5/10/2018

OVERVIEW

The files in this directory pertain to gliomas (brain tumors) and how MATLAB handles neuroimage processing using edge segmentation as well as density thresholds. 

WHERE TO START

To begin, take a look at MasterScript.m. You will want to look at each function and script individually, but let it walk you through the entire project first before you explore further. Hit run and when it prompts you to evaluate the accuracy of the tumor detection function, press ‘y’ to run the detection.m file. This is the user evaluation portion of my project, during which YOU will manually evaluate the accuracy of my program’s automated tumor detection capabilities. First, I highly recommend you check out the subplot figure that pops up as it contains a clear representation of all the images I was working with through the course of this project. After viewing the images, it is time to move onto the user input portion. Remember: hit the ‘Enter’ key if the image displayed on the rightmost side of the figure properly depicts the outlines of the glioma. Hit the ’n’ key and then the ‘Enter’ key if some other region of the MRI scan is outlined (not the tumor). This process will take roughly 2-4 minutes for all 15 images and 9 thresholds, so please be patient. Also, the last 5 images should yield the message box “No tumors were detected for this threshold” roughly 45 times. If this happens, that is what is supposed to happen. Just let the program do its thing. 

For the second phase of my project, an error analysis consisting of 3 figures and one Matlab generated image/figure will pop up. Take a look at these figures and then close them. The command window will ask if you are ready to interact with the custom error analysis GUI window. Respond by hitting the ‘y’ key followed by the ‘Enter’ key. Play around with the checkboxes. Note: hitting the ‘GO!’ push button doesn’t update the graphs; it simply saves new data. To plot this new data, you have to click on the push buttons directly under each graph. Tip: try selecting images 1-5 alone, 6-10 alone, or 1-10 to analyze the accuracy of the tumor detection function with respect to specific data of known ‘benign’ or ‘malignant’ classification. That’s pretty much the gist of my project. After you see the message “That’s my project! Thank you!” in the command window, you have made it through my master script. From there, I recommend you check out the ‘tumorStats.txt’ file and then watch the videos I uploaded to youtube. I hope you find this project interesting!

DATA INPUT

• All the data for input is provided in the files given. Specifically, take a look at what is stored in inputData.mat and what is stored in inputImages.jpg after running the detection.m script.
• The data you will be inputting is the evaluation of the tumor detection accuracy via ‘Enter’ key or ’n’ key. This logical data will then be 
• Finally, you will again input data by selecting images for which you want a specified error analysis.

>> inputData.mat - holds a cell array of the 15 images imported via imread as well as their corresponding glioma classification (1 for benign, 2 for malignant, 0 for no tumor).
>> detection.mat - holds the ‘isDetected’ cell array, ‘knownClassification’ vector, ‘thresholds’, and ‘tumorStats’. This .mat file is loaded at the beginning of the ‘errorAnalysis.m’ script as well as the ‘customErrorAnalysis.m’ function.
>> guiPlotting.mat - holds a long list of variables which are used to update the graphs in the GUI window depending on which checkboxes are selected by the user.

OUTPUT FILES

1. inputImages.jpg - A 5x3 subplot of all the images this project will be working with. The first 5 are benign glioma MRI scans, the second 5 are malignant glioma MRI scans, and the last 5 are clean MRI scans (no tumor presented). 

2. tumorStats.txt - A text file with image number, classification, area values (in pixels) of the tumor region and whole brain region, and tumor to brain ratio. There are also statistics by classification which are averaged and displayed as a tumor-to-brain area percentage to get a sense of the various data inputted.

3. roc.fig - A manually created roc curve based on logistic regression data. Note: the figure is not too meaningful because no “false alarms” or false positives were recorded from the data. Therefore, the false positive rate was 0 for every data point, making the curve “perfect.” In reality, if the sample size were bigger, there would surely be false positive rates greater than 0, and the ROC curve would be more interesting.

4. roc.jpg - This graph was plotted via Matlab’s built-in ‘plotroc’ function. It seems as if only one data point other than (0,0) and (1,1) was plotted, making the graph look a bit wonky. Since I did not code the function myself, I cannot quite decipher what exactly is being plotted, so it is fair to say that the figure does not offer great insight about the accuracy of the tumor detection function with respect to various thresholds.

5. performanceAnalysis.fig - Two figures that offer the most meaningful analysis of the tumor detection function. The first one plots classification rates vs. thresholds, depicting the percentage of images for which the function detected the tumor perfectly, inaccurately, or inadvertently– at each respective density threshold. The second figure plots performance analysis statistics such as performance index, sensitivity, specificity, and accuracy against the 9 density thresholds (see PPT to learn more about performance analysis statistics).


FUNCTIONS AND SCRIPTS

1. ‘MasterScript.m’ script >> calls scripts and functions / outlines the whole project so that you don’t need to manually run anything if you do not want to.

2. ** ‘tumorDetection.m’ function ** >> [This function took up the bulk (6 hours) of my time. It was the most sophisticated image processing technique to play around with and understand] The first thing it does is it converts the grayscale image to a binary image ‘bw’ by replacing all pixels with a luminance value greater than 0.7 (so relatively white) with 1s and setting the rest of the pixels to the value 0. It then calls the Matlab function ‘bwlabel’ to identify the “object” or brain part of the MRI scan by finding all the connected components in ‘bw’. It retrieves stats from the new labeled “object” called ‘label’ by calling Matlab’s ‘regionprops’ function. Specifically, the program is curious about the density and area statistics held in the ‘stats’ structure created by ‘regionprops.’ (Note: I learned how to use these functions by watching video after video on Matlab’s videos and webinar help site. I watched lots of medical image processing videos as well as tumor detection videos, most of which used ‘regionprops’ to isolate some variable for detection purposes.). The code then searches for areas which have a density value greater than the threshold argument passed into the function; it defines all such areas as highDensityArea. If none are returned, the detection variable is set to false and the function ends. If a highDensityArea is, in fact, detected, it calls Matlab’s built-in ‘max’ function to detect the area of maximum density, labels this area ‘tumorLabel’ using the ‘find’ function, and defines ‘tumor’ as the area where ‘label’ is a member of ‘tumorLabel’ (using the ‘ismember’ function). I discovered the next two functions from a youtube video about density threshold edge segmentation, which is cited in my PPT on the references slide] The functions ‘strel’ and ‘imdilate’ essentially help to isolate the tumor from the region of maximum density at the specified threshold. Next, some tumor stats are computed. These are stored in a structure called ‘area’ which will later be saved and passed into the function ‘tumorStatsFileWrite.’ Next, the function makes a 1x3 subplot showing the original MRI scan, the tumor alone using ‘bwboundaries’, and the outlines of the tumor overlaid on the original image. Finally, the user is prompted to hit the ‘Enter’ key if the detection of the tumor was accurate. If not, the user is instructed to hit the ’n’ key followed by the ‘Enter’ key to store the value 0 into the output logical variable ‘detection.’

3. ’detection.m’ script >> creates a subplot of all 15 images held in the ‘img’ cell array so that the user can visually see what images are being processed. Then, it guides the user through 15x9 calls of tumorDetection at thresholds ranging from 0.1 to 0.9 (increments of 0.1) to retrieve logical data about the accuracy of the tumor detection function. Finally, it passes the cell array ‘tumorStats’ and vector ‘knownClassificaiton’ into the ‘tumorStatsFileWrite’ function to create the text file ‘tumorStats.txt.’

4. ‘tumorStatsFileWrite.m’ function >> [uses low-level file input/output commands] opens a new text file using ‘fopen’ and writes a tab-delimited table to the file ‘tumorStats.txt.’ Following the ‘writetable’ function, it computes the average tumor area to brain area ratio for benign glioma MRI scans, malignant glioma MRI scans, and clean MRI scans, respectively. It appends these three values to the file using the ‘fprintf’ command and then closes out the text file using ‘fclose.’

5. ‘errorAnalysis.m’ script >> performs a logistic regression error analysis using the user-evaluation cell array ‘isDetected’ and the vector ‘knownClassification.’ A receiver operating characteristic curve is plotted (true positive rate vs. false positive rate) and two performance classification analysis figures are also created from 3 vectors: perfect classification (‘PC’), missed classification (‘MC’), and false alarm (‘FA’). Many vectors are displayed in the command window for easy reference if the graphs seem confusing. Matlab’s ‘plotroc’ function is also tested out, and the figure is saved as an image called ‘roc.jpg.’

6. ‘errorAnalysisGUI.m’ function >> [uses GUIDE to create a graphic user interface window] allows the user to select checkboxes corresponding to which images for which they would like to see a customized error analysis. The ‘GO!’ push button saves the checkbox values and assigns them into a cell array in the workspace. All non-zero values in this vector are then passed into the function ‘customErrorAnalysis’ as future index values for retrieval of specific data. The push buttons under each graph are coded to update the graph, making it correspond to the error analysis graph specifically produced based on the checked boxes saved from when the user last hit the ‘GO!’ push button. Notice how the text displayed on the push buttons under the graph change from ‘Reveal Graph’ to ‘Update Graph’ after the user clicks on them once.

7. ‘customErrorAnalysis.m’ function >> essentially does the same thing as the ‘errorAnalysis’ script. The only difference is that it takes the argument checkboxValues, makes a vector called indices which saves the indices at which checkboxValues holds 1s. It extracts data from these specific indices and then saves all the variables needed to plot a new graph into the .mat file called ‘guiPlotting.mat.’ Since this function is called from inside the pushbutton1 callback function and so many different variables are needed to plot the new graphs, the .mat file is used instead of assigning all important variables to a long list of outputs in the function.

USEFUL DEFINITIONS

1. Glioma - a cancerous tumor of the brain that begins in glial cells (cells that surround and support nerve cells).

2. ROC - in statistics, a receiver operating characteristic curve (ROC curve) is a graphical plot that illustrates the diagnostic ability of a binary classifier system as its discrimination threshold is varied. The ROC curve is created by plotting the true positive rate (TPR) against the false positive rate (FPR) at various threshold settings. The true-positive rate is also known as sensitivity, recall or probability of detection in machine learning. The false-positive rate is also known as the fall-out or probability of false alarm and can be calculated as (1 − specificity). The area under the ROC curve is typically a good indicator of the overall ability of the detection method to discriminate between scans with a glioma (and further, identify the glioma accurately) and healthy brain scans. A truly useless test (one no better at identifying true positives than flipping a coin) has an area of 0.5. A perfect test (one that has zero false positives and zero false negatives) has an area of 1.00.

3. Sensitivity - the proportion of true positives or the proportion of cases correctly identified by the test as meeting a certain condition

4. Specificity -  the proportion of true negatives or the proportion of cases correctly identified by the test as not meeting a certain condition

5. Performance Classification Analysis - a slight variation of a logistic regression error analysis. Instead of using logical variables, there are three variables: perfect classification, missed classification, and false alarm. These variables are then analyzed and stats like performance index, sensitivity, specificity, and accuracy can be investigated further.

6. Craniotomy - surgical removal of part of the bone from the skull to expose the brain. In the context of glioma treatment, some craniotomy procedures use the guidance of computers and imaging (magnetic resonance imaging [MRI] or computerized tomography [CT] scans) to reach the precise location within the brain that is to be treated.

7. Laser Ablation - MRI-guided laser ablation is a minimally invasive neurosurgical technique for a number of diseases, including brain tumors. The treatment uses lasers to target and destroy, or ablate, the tumor.



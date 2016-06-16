%% Fundemental Setting 
clear all; close all;

projectName = 'gabor_W_4_O_90_KDEF';
training = imageSet('train_KDEF', 'recursive');

% imgSize = [280,180];
%% Test 
% img = read(training(1),1);
% img = imresize((img), imgSize, 'bicubic');
% img = extractHOGFeatures(img, 'CellSize', cellSize);
% [img, visu] = extractHOGFeatures(img,'CellSize', cellSize);
% % imshow(img); hold on;plot(visu);
% HOGsize = size(img,2);         

%% Extract Feature

% ====== Paramter of Feature======
% cellSize = [8 8];
% blockSize = [2 2];
% flag4Cascade = 0;
wavelength = 4;
orientation = 90;

% ========= End ==========

sum = 0; for i=1:length(training),sum = sum + training(i).Count; end

trainingFeature = [];
featureCount=1;
faceDetector = vision.CascadeObjectDetector;

for idx=1:length(training)
    for num=1:training(idx).Count
       img = read(training(idx),num);
%============= Feature Extraction===========
% _____HOG_____
%            tmp = extractHOGFeatures(img, 'CellSize', cellSize);
% _____Gabor_____
%             scaleRatio = 1/2;
%             img = imresize(img,scaleRatio);
%             I = rgb2gray(img);
%             [mag, phase] = imgaborfilt(I, wavelength, orientation);
%             tmp = mag(:)';
% ____ Haar Like____
% ================== End ====================
           trainingFeature = [trainingFeature;tmp];
           trainingLabel{featureCount} = training(idx).Description;
           featureCount = featureCount +1;
%        end
    end
end
%%
save(strcat(projectName,'_features.mat'), 'trainingFeature');
save(strcat(projectName,'_label.mat'), 'trainingLabel');

%% Classifier
faceClassifier = fitcecoc(trainingFeature, trainingLabel);
save(strcat('classifier', projectName, '.mat'), 'faceClassifier');


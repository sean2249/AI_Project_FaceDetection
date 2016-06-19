%% Fundemental Setting 
clear all; close all;

addpath('./myFunction')

% projectName = 'gabor_AllWavelengthOrientation_KDEF';
projectName = 'HOG_KDEF';
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
cellSize = [4 4];
blockSize = [8 8];
% flag4Cascade = 0;
% wavelength = 4;
% orientation = 90;
% scale = 1/2;
% ========= End ==========

sum = 0; for i=1:length(training),sum = sum + training(i).Count; end

trainingFeature = [];
featureCount=1;
faceDetector = vision.CascadeObjectDetector;

fprintf('Start Extracting\n');
faceDetector = vision.CascadeObjectDetector();

for idx=1:length(training)
% for idx=1:5
    for num=1:training(idx).Count
        feature = [];
        img = read(training(idx),num);
        
%         detect face ROI
        bbox = step(faceDetector, img);
        [~, maxIndex] = max(bbox(:,3).*bbox(:,4));
        img = imcrop( img, bbox(maxIndex,:) );
        
        img = imresize(img, [400 400]);
        img = rgb2gray(img);
%         img = histeq(img);
        level = graythresh(img);
        img = im2bw(img, level);
%============= Feature Extraction===========
% _____HOG_____
%         [feature, fv] = extractHOGFeatures(img, 'BlockSize', blockSize, 'CellSize', cellSize);
        [feature, fv] = extractHOGFeatures(img);
%         imshow(img); hold on
%         plot(fv);
%         pause(1);
% _____Gabor_____
%         for wavelength = 2.5:2.5:12.5
%             for orientation = 0:30:150
%             for orientation = 45:45:90
%                 tmp = gaborExtract(img, wavelength, orientation, scale);
%                 tmp = gaborExtract(img, 2, 45, [400 300]);
%                 feature =[feature tmp];
%             end
%         end
%         tmp = gaborExtract(img, 4, 90, scale);
%         feature =[feature tmp];
% ____Haar Like____
% ================== End ====================
        trainingFeature = [trainingFeature;feature];
        trainingLabel{featureCount} = training(idx).Description;
        featureCount = featureCount +1;
    end
end

fprintf('Finish Extraction\n');

%%
save(strcat(projectName,'_features.mat'), 'trainingFeature');
save(strcat(projectName,'_label.mat'), 'trainingLabel');

%% Classifier
% faceClassifier = fitcecoc(trainingFeature, trainingLabel);
% save(strcat('classifier', projectName, '.mat'), 'faceClassifier');

% [model,predict] = trSVM(projectName, trainingFeature, trainingLabel);

fprintf('Done\n');
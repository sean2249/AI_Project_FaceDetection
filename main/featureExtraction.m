%% Fundemental Setting 
clear all; close all;

addpath('./myFunction')

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
cellSize = [8 8];
blockSize = [2 2];
flag4Cascade = 0;
size = [762 562];
% wavelength = 8;
% orientation = 90;
% scale = 1/2;
% ========= End ==========

sum = 0; for i=1:length(training),sum = sum + training(i).Count; end

trainingFeature = [];
featureCount=1;
faceDetector = vision.CascadeObjectDetector;

fprintf('Start Extracting\n');

for idx=1:length(training)
    fprintf('%d- Extraction\n', idx);
    for num=1:training(idx).Count
       img = read(training(idx),num);
%============= Feature Extraction===========
% _____HOG_____
           img = imresize(img, size);
           feature = extractHOGFeatures(img, 'CellSize', cellSize);
% _____Gabor_____
%     feature = [];
%     for wavelength = 2.5:2.5:12.5
%         for orientation = 0:30:150
%             tmp = gaborExtract(img, wavelength, orientation, scale);
%             feature =[feature s1 s2 s3];
%         end
%     end
% ____ Haar Like____
% ================== End ====================
           trainingFeature = [trainingFeature;feature];
           trainingLabel{featureCount} = training(idx).Description;
           featureCount = featureCount +1;
%        end
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
%% Fundemental Setting 
clear all; close all;

addpath('./myFunction')


training = imageSet('train_KDEF', 'recursive');

% imgSize = [280,180];
%% Test 
% img = read(training(1),1);
% % img = imresize((img), imgSize, 'bicubic');
% img = extractHOGFeatures(img, 'CellSize', cellSize);
% [img, visu] = extractHOGFeatures(img,'CellSize', cellSize);
% % imshow(img); hold on;plot(visu);
% HOGsize = size(img,2);         

%% Extract Feature

% ====== Paramter of Feature======
cellSize = [8 8];
blockSize = [2 2];
flag4Cascade = 0;
% size = [762 562];
% wavelength = 8;
% orientation = 90;
% scale = 1/2;
% ========= End ==========

sum = 0; for i=1:length(training),sum = sum + training(i).Count; end

trainingFeature = [];
featureCount=1;
% faceDetector = vision.CascadeObjectDetector;

fprintf('Start Extracting\n');

for iii=1:10
    trainingFeature = [];
    trainingLabel={};
    hog =0;
    featureCount = 1;
    switch iii
        case 1
            scale = 1/4;
            cellSize = [32 32];
            hog =1;
        case 2
            cellSize = [8 8];
            hog =1;
            scale = 1/2;
        case 3
            wavelength = 8;
            orientation = 0;
            scale = 1/2;
        case 4
            wavelength = 4;
            orientation = 0;
            scale = 1/2;
        case 5
            wavelength = [4 8];
            orientation = 0;
            scale = 1/2;
        case 6
            wavelength = 4;
            orientation = [0 45];
            scale = 1/2;
        case 7
            wavelength = 4;
            orientation = [0 45 90];
            scale = 1/2;
        case 8
            wavelength =[4 8];
            orientation = [0 45 90];
            scale = 1/2;
        case 9
            hog =1;
            cellSize = [16 16];
            scale = 1/2;
        case 10
            hog = 1;
            cellSize = [32 32];  
            scale = 1/2;
        case 11
            cellSize = [4 4];
            hog = 1;
            scale = 1/2;
    end
    
    
projectName = strcat(num2str(iii), '_KDEF');

for idx=1:length(training)
%     fprintf('%d- Extraction\n', idx);
    for num=1:training(idx).Count
       img = read(training(idx),num);
% =========== Preprocessing ============

%     fileName = training(idx).name;
%       if (fileName(7)=='S')
%           xxx = input(fileName);
%           label = fileName(5:6);
%       end
       
%============= Feature Extraction===========
% _____HOG_____
%            img = imresize(img, size);
if hog==1
            img = imresize(img, scale);
           feature = extractHOGFeatures(img, 'CellSize', cellSize);
else
% _____Gabor_____
        feature = [];
        for wavelength = 2.5:2.5:12.5
            for orientation = 0:30:150
                tmp = gaborExtract(img, wavelength, orientation, scale);
                feature =[feature tmp];
            end
        end
end
% ____ Haar Like____
% ================== End ====================
           trainingFeature = [trainingFeature;feature];
           trainingLabel{featureCount} = training(idx).Description;
           featureCount = featureCount +1;
%        end
    end
    
end

% fprintf('Finish Extraction\n');

%%
save(strcat(projectName,'_features.mat'), 'trainingFeature');
save(strcat(projectName,'_label.mat'), 'trainingLabel');

movefile(strcat(projectName,'_features.mat'), 'F:/');
movefile(strcat(projectName,'_label.mat'), 'F:/');
%% Classifier
% faceClassifier = fitcecoc(trainingFeature, trainingLabel);
% save(strcat('classifier', projectName, '.mat'), 'faceClassifier');

% [model,predict] = trSVM(projectName, trainingFeature, trainingLabel);
%%
feature = trainingFeature;

cators = unique(trainingLabel);
label = zeros( length(trainingLabel), 1 );
M = containers.Map(cators,1:length(cators));
for i=1:length(trainingLabel)
    label(i, 1) = M(trainingLabel{i});
end

% setting validation index,
validationSize = 80;
randInd = randperm(length(label));
trainRainge = length(label)-validationSize;
trainInd = randInd(1:trainRainge);
valInd = randInd(trainRainge+1:end);

option = '-t 0 -d 2 -g 2 -c 1 -e 0.1';
model = svmtrain(double(label(trainInd)), double(feature(trainInd,:)), option);

save(strcat(projectName,'_model.mat'), 'model');
movefile(strcat(projectName,'_model.mat'),'F:/');

fprintf('Done\n');
end
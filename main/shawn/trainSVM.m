clear;
addpath(genpath('libsvm-3.21/'));
% load('gabor_AllWavelengthOrientation_KDEF_features.mat');
% load('gabor_AllWavelengthOrientation_KDEF_label.mat');
% load('KDEF_features.mat');
% load('KDEF_label.mat');
% load('gabor_W_4_O_90_KDEF_features.mat');
% load('gabor_W_4_O_90_KDEF_label.mat');
% load('gabor_W_4_O_90_KDEF_features_2.mat');
% load('gabor_W_4_O_90_KDEF_label_2.mat');
load('HOG_KDEF_features.mat');
load('HOG_KDEF_label.mat');
% load('gabor_W_4_O_45_90_KDEF_features.mat');
% load('gabor_W_4_O_45_90_KDEF_label.mat');

feature = trainingFeature;

cators = unique(trainingLabel);
label = zeros( size(trainingLabel,2), 1 );
M = containers.Map(cators,1:size(cators,2));
for i=1:size(trainingLabel,2)
    label(i, 1) = M(trainingLabel{i});
end

% setting validation index,
validationSize = 50;
randInd = randperm(size(label,1));
trainRainge = size(label)-validationSize;
trainInd = randInd(1:trainRainge);
valInd = randInd(trainRainge+1:end);

option = '-s 0 -t 2 -d 3 -g .0001 -c 1000';
model = svmtrain( double(label(trainInd)), double(feature(trainInd,:)), option );
save('HOG_KDEF_model.mat','model','-v7.3');
save('HOG_KDEF_cators.mat','cators','-v7.3');

% validation
[predicted_label, accuracy, ~] = svmpredict( double(label(valInd)), double(feature(valInd,:)), model );

% confusion matrix
[C, order] = confusionmat( double(label(valInd)), predicted_label);
C
option
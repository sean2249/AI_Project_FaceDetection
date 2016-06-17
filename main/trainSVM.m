clear;

load('KDEF_features.mat');
load('KDEF_label.mat');
% load('gabor_W_4_O_90_KDEF_features.mat');
% load('gabor_W_4_O_90_KDEF_label.mat');

feature = trainingFeature;

cators = unique(trainingLabel);
label = zeros( size(trainingLabel,2), 1 );
M = containers.Map(cators,1:size(cators,2));
for i=1:size(trainingLabel,2)
    label(i, 1) = M(trainingLabel{i});
end

% setting validation index,
validationSize = 80;
randInd = randperm(size(label,1));
trainRainge = size(label)-validationSize;
trainInd = randInd(1:trainRainge);
valInd = randInd(trainRainge+1:end);

option = '-t 0 -d 2 -g 2 -c 1 -e 0.1';
model = svmtrain(double(label(trainInd)), double(feature(trainInd,:)), option);

[predicted_label, accuracy, ~] = svmpredict(double(label(valInd)), double(feature(valInd,:)), model);
[C, order] = confusionmat( double(label(valInd)), predicted_label)
% C = strsplit(option, {' ','-','.'});
% par = strcat(C{:});
% save(['model_MIX_' par '.mat'],'model_MIX');

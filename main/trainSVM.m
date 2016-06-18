% clear;

% load('gabor_MIXwithMeanStdMedian_KDEF_label.mat');
% load('gabor_MIXwithMeanStdMedian_KDEF_features.mat');

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

[predicted_label, accuracy, ~] = svmpredict(double(label(valInd)), double(feature(valInd,:)), model);

predictedName = {};
for idx=1:length(predicted_label)
    predictedName{idx} = cators(1, predicted_label(idx,1));
end

[C, order] = confusionmat( double(label(valInd)), predicted_label)

% C = strsplit(option, {' ','-','.'});
% par = strcat(C{:});
% save(['model_MIX_' par '.mat'],'model_MIX');

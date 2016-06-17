function [model,output] = trSVM(project, trainingFeature, trainingLabel)
% load('gabor_W_4_O_90_KDEF_features.mat');
% load('gabor_W_4_O_90_KDEF_label.mat');

feature = trainingFeature;

cators = unique(trainingLabel);
label = zeros( size(trainingLabel,2), 1 );
M = containers.Map(cators,1:size(cators,2));
for i=1:size(trainingLabel,2)
    label(i, 1) = M(trainingLabel{i});
end

option = '-t 0 -d 2 -g 2 -c 1 -e 0.1';
model = svmtrain(double(label), double(feature), option);

save(strcat(project,'Model.mat'));
[output] = svmpredict(double(label), double(feature), model);

% C = strsplit(option, {' ','-','.'});
% par = strcat(C{:});
% save(['model_MIX_' par '.mat'],'model_MIX');


end
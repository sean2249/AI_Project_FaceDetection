function allModel = trainModel(prm)
if ~exist(prm.saveFeatureName,'file')
    featureExtraction(prm)
end
load(prm.saveFeatureName);

features = trainingFeature(1:prm.validation:end, :);
label    = trainingLabel(1:prm.validation:end, :);

for type=1:length(unique(label))
 spLabel = label;
 spLabel(spLabel~=type) = 2;
 allModel{type} = svmtrain(spLabel, features, prm.command);
end

save(prm.modelName, 'allModel');

% keyboard;
accuracy = zeros(length(prm.validation),1);
if prm.validation~=1
    % Validation Set 
    
    for valiSet = 1:prm.validation
    %     keyboard;
        features = trainingFeature(1+valiSet:prm.validation:end, :);
        label    = trainingLabel(1+valiSet:prm.validation:end, :);
        prob = [];
        for type=1:length(allModel)
           [a,b,c]=svmpredict(label, (features), allModel{type}, ' -b 1 ');
           if isempty(c)
               c = zeros(length(label),1);
           end
            prob=[prob,c(:,1)]; 
        end
        [~, result] = max(prob,[],2);
        confMat = confMatGet(label, result);
        confMatPlot(confMat);
        ylabel('predict');
        
        missIdx = find(label~=result);
        accuracy(valiSet,1) = length(missIdx)/length(label);
%         fprintf('Accuracy = %.2f \n',accuracy*100);
        
    end
else
    
    features = trainingFeature(1:validation:end, :);
    label = trainingLabel(1:validation:end, :);
    prob = [];
    for type=1:length(allModel)
       [a,b,c]=svmpredict(label, (feautres), allModel{type}, ' -b 1 ');
       if isempty(c)
           c = zeros(length(label),1);
       end
       prob = [prob,c(:,1)];
    end
    [~, result] = max(prob,[],2);
    conMat = confMatGet(label, result);
    confMatPlot(conMat);
    ylabel('predict');
    
    missIdx = find(label~=result);
    accuracy = length(missIdx)/length(label);
    
end

% keyboard;
for idx=1:length(accuracy)
    fprintf('Accuracy = %.2f \n',accuracy(idx,1)*100);
end




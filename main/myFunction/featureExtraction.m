function featureExtraction(prm)
%% Fundemental Setting 

if nargin<1
    prm.imagePath = './train_KDEF';
end

training = imageSet(prm.imagePath, 'recursive');
%% Extract Feature

% ====== Paramter of Feature======
cellSize = [4 4];
blockSize = [8 8];
% ========= End ==========

trainingFeature = [];
trainingLabel = [];

fprintf('Start Extracting\n');
for idx=1:length(training)
    trainingLabel = [trainingLabel;repmat(idx, [training(idx).Count,1])];
    for num=1:training(idx).Count
        fprintf('$ Processing: %d in %d \n',idx,num);
        feature = [];
        img = read(training(idx),num);
        img = imresize(img, [400 300]);
        img = rgb2gray(img);
        img = histeq(img);
        level = graythresh(img);
        img = im2bw(img, level);
%============= Feature Extraction===========
% _____HOG_____
        [feature, fv] = extractHOGFeatures(img);
%         imshow(img); hold on
%         plot(fv);
%         keyboard;
% ================== End ====================
        trainingFeature = [trainingFeature;double(feature)];
    end
end

%%
save(prm.saveFeatureName, 'trainingFeature', 'trainingLabel');
fprintf('Done\n');
%% Load type of mood and music, model & cators
clear 
addpath('./myFunction')
addpath('./shawn')
addpath('./GTZAN')

prm.imagePath = './train_KDEF';   
prm.saveFeatureName = '20160806_hog.mat';
prm.modelName = 'HOG_KDEF_model_2.mat';
prm.command = '-s 0 -t 2 -c 1 -b 1 ';
prm.validation = 20;

[typeLabel,cators, allModel, musicClipNote] = initalLabelSetting(prm);

%% Get image 
img = startCam;

%% Preprocessing 
figure;
subplot(1,2,1); imshow(img); title('Original face');
img = imresize(img, [400 300]);
img = rgb2gray(img);
img = histeq(img);
level = graythresh(img);
img = im2bw(img, level);
subplot(1,2,2); imshow(img); title('Preprocessing image');
feature = extractHOGFeatures(img);  

%% Predict mood 
cator = 1;
prob=[];

for type=1:length(allModel)
   [a,b,c]=svmpredict(cator, double(feature), allModel{type}, ' -b 1 ');
   if isempty(c)
       c = zeros(length(cator),1);
   end
    prob=[prob,c(:,1)]; 
end

[~, result] = max(prob,[],2);
fprintf('=======================\n');
predictMood = cators{result};
fprintf( 'predicted: %s\n',  predictMood);
fprintf('=======================\n')

%% Ouput Song title
songRecommend= mood2songTitle(predictMood, musicClipNote);

for num=1:length(songRecommend)
    songType = songRecommend{num}.type;
    songName = songRecommend{num}.name;
    songIdx = str2double(songRecommend{num}.idx);
    filePath{num} = strcat('./GTZAN/', songType,'/', songType, '.', num2str(songIdx, '%05d'), '.wav');
end

for num=1:length(songRecommend)
    pause(1.5);
    fprintf('=== Recommend Song__%d\n', num);
     fprintf('Song Type: %s\n', songRecommend{num}.type);
    fprintf('Song Name: %s\n', songRecommend{num}.name);
    [songClip, fs] = audioread(cell2mat(filePath(num)));
    player = audioplayer(songClip, fs);
    playblocking(player);   
end
fprintf('=======================\n')
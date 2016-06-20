%% Load type of mood and music, model & cators
clear 
addpath('./myFunction')
addpath('./shawn')
addpath('./GTZAN')
[~, model, cators, musicClipNote] = initalLabelSetting();

%% Get image 
img = startCam;

%% Preprocessing 
img = rgb2gray(img);
% img = histeq(img);
img = imresize(img, [400 400]);
level = graythresh(img);
img = im2bw(img, level);
figure;imshow(img);
feature = extractHOGFeatures(img);

%% Predict mood 
cator = 1;
[p,a,~]=svmpredict( cator, double(feature), model );
predictMood = cators{p};
% fprintf( 'label: %s\n', cators{cator} );
fprintf( 'predicted: %s\n',  predictMood);

%% Ouput Song title
songRecommend= mood2songTitle(predictMood, musicClipNote);

for num=1:length(songRecommend)
    songType = songRecommend{num}.type;
    songName = songRecommend{num}.name;
    songIdx = str2double(songRecommend{num}.idx);
    filePath{num} = strcat('./GTZAN/', songType,'/', songType, '.', num2str(songIdx, '%05d'), '.wav');
end
[songClip, fs] = audioread(cell2mat(filePath(1)));
sound(songClip,fs);
fprintf('Song Type: %s\n', songRecommend{1}.type);
fprintf('Song Name: %s\n', songRecommend{1}.name);

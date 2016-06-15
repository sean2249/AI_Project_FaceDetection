%% Need faceClassifier
folder = 'trainset';
files = dir(fullfile(strcat('./',folder,'/*.png')));
for idx=1:length(files)
    img = imread(strcat('/',folder,'/',files(idx).name));
    img = imresize((img), imgSize, 'bicubic'); imshow(img);
    img = extractHOGFeatures(img, 'CellSize', cellSize);
    Label = predict(faceClassifier, img);
    title(Label);
    xxx=input('Wait'); close all;
end
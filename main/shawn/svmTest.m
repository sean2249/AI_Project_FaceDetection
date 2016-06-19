clear;
load('HOG_KDEF_model.mat');
load('HOG_KDEF_cators.mat');
addpath(genpath('libsvm-3.21/'));
% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

cator = 1;
index = 3;
img = imread( ['testfile/' num2str(cator) '_' num2str(index) '.jpg'] );

% detect face ROI
bbox = step(faceDetector, img);

% Draw the returned bounding box around the detected face.
% videoOut = insertObjectAnnotation(img,'rectangle',bbox,'Face');
% figure, imshow(videoOut), title('Detected face');

[~, maxIndex] = max(bbox(:,3).*bbox(:,4));
img = imcrop(img, bbox(maxIndex,:));
img = imresize(img, [400 400]);

% imshow(img);

img = rgb2gray(img);
% img = histeq(img);
level = graythresh(img);
img = im2bw(img, level);
imshow(img);

feature = extractHOGFeatures(img);
[p,a,~]=svmpredict( cator, double(feature), model );
fprintf( 'label: %s\n', cators{cator} );
fprintf( 'predicted: %s\n', cators{p} );

cam = webcam
preview(cam);
faceDetector = vision.CascadeObjectDetector;

%%
img = snapshot(cam);
bboxes = step(faceDetector, img);
IFaces = insertObjectAnnotation(img, 'rectangle', bboxes, 'Face');
figure, imshow(IFaces), title('Detected faces');

%%
idx =[ bboxes(1), bboxes(1)+bboxes(3), bboxes(2), bboxes(2)+bboxes(4) ] ;
imgCrop = img(idx(3):idx(4), idx(1):idx(2),:);
imshow(imgCrop);
%% 






%%
% %%
% for idx =1:100
%    % Acquire a single image.
%    rgbImage = snapshot(cam);
%    
%   % Convert RGB to grayscale.
% %    grayImage = rgb2gray(rgbImage);
% 
%    % Find circles.
% %    [centers, radii] = imfindcircles(grayImage, [60 80]);
% 
%    % Display the image.
% %    imshow(rgbImage);
% %     rgbImage = imresize(rgbImage, 1/5);
% %    [hog, visu] = extractHOGFeatures(rgbImage);    
% %    plot(visu)
%     bboxes = step(faceDetector, rgbImage);
%     IFaces = insertObjectAnnotation(rgbImage, 'rectangle', bboxes, 'Face');
%    figure, imshow(IFaces), title('Detected faces');
% 
% 
%    hold on;
% %    imshow(rgbImage); 
% %    viscircles(centers, radii);
%    drawnow
% end

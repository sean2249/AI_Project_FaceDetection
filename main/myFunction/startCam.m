function imgCrop = startCam(duration, count)
% For capture face from webcam
% Default: duration = 0.5, count = 4
if nargin<1, duration = 0.7; count = 4; end
if nargin<2, count = 4; end

[img, bboxes] = takePhoto(duration,count);
% keyboard;
while isempty(bboxes)
    fprintf('======No face detect=====\n');
    [img, bboxes] = takePhoto(duration,count);
end

idx = 1;
if size(bboxes,1) ~=1
    area = 0;
    for i=1:size(bboxes,1)
        tmp = bboxes(i,3) * bboxes(i,4);
        if tmp>area, idx =i; area = tmp; end
    end
end
    idx =[ bboxes(idx,1), bboxes(idx,1)+bboxes(idx,3), bboxes(idx,2), bboxes(idx,2)+bboxes(idx,4)*1.08 ] ;
    if idx(4)>=size(img,1), idx(4) = size(img,1); end
    if idx(2)>=size(img,2), idx(2) = size(img,2); end
    imgCrop = img(idx(3):idx(4), idx(1):idx(2),:);
    figure; imshowpair(img,imgCrop,'montage')
end

% ------ %
function [img, bboxes] = takePhoto(duration,count)
    cam = webcam;
    preview(cam);

    fprintf('Take photo after 3 seconds\n');
    pause(2.5);

    imgTotal = [];
    for num=1:count
       img = snapshot(cam);  
       imgTotal =cat(4,imgTotal,img);
       pause(duration);
    end
    closePreview(cam); clear cam; 
    
    figure;
    
    for num=1:size(imgTotal,4)
       imageTitle= strcat(num2str(num), ' Image');
       subplot(ceil(count/2),2,num); imshow(imgTotal(:,:,:,num));
       title(imageTitle); 
    end
    choose = 0;
    while ~and(choose<=size(imgTotal,4), choose>0)
        choose = input('Choose the photo you want: ');
    end
    img = imgTotal(:,:,:,choose);
    close all;
    faceDetector = vision.CascadeObjectDetector;
    bboxes = step(faceDetector, img);
end
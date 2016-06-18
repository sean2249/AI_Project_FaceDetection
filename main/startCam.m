function imgCrop = startCam(duration, count)
% For capture face from webcam
% Default: duration = 0.5, count = 4
if nargin<1, duration = 0.5; count = 4; end
if nargin<2, count = 4; end
cam = webcam;
preview(cam);
faceDetector = vision.CascadeObjectDetector;

%% 
% count = 5;
imgTotal = snapshot(cam);
num = count;
while num>1
   img = snapshot(cam);  
   imgTotal =cat(4,imgTotal,img);
%    figure; imshow(img)
   pause(duration);
   num = num -1;
end
closePreview(cam); clear cam; 
%%
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
%%
bboxes = step(faceDetector, img);
IFaces = insertObjectAnnotation(img, 'rectangle', bboxes, 'Face');
figure, subplot(1,2,1), imshow(IFaces), title('Detected faces');

%%
if ~isempty(bboxes)
    idx = 1;
    if size(bboxes,1) ~=1
        area = 0;
        for i=1:size(bboxes,1)
            tmp = bboxes(i,3) * bboxes(i,4);
            if tmp>area, idx =i; area = tmp; end
        end
    end
        idx =[ bboxes(idx,1), bboxes(idx,1)+bboxes(idx,3), bboxes(idx,2), bboxes(idx,2)+bboxes(idx,4) ] ;
        imgCrop = img(idx(3):idx(4), idx(1):idx(2),:);
        subplot(1,2,2);imshow(imgCrop);
else
   fprintf('No face detect\n'); 
end

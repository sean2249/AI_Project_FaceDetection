faceDetector = vision.CascadeObjectDetector;
bboxes = step(faceDetector, img);

IFaces = insertObjectAnnotation(img, 'rectangle', bboxes, 'Face');
figure, imshow(IFaces), title('Detected faces');


for i=1:size(bboxes,1)
    tmp = img(bboxes(i,1):bboxes(i,1)+bboxes(i,3),bboxes(i,2):bboxes(i,1)+bboxes(i,4),:);
    imgSet=[imgSet;tmp];
end
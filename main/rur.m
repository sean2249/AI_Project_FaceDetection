%%
% Get label of face
[faceLabel, musicLabel] = initalLabelSetting();
load './shawn/HOG_KDEF_model.mat'
load './shawn/HOG_KDEF_cators.mat'
img = startCam;




%%
folder = dir('./train_KDEF/sad/*.jpg');
for i=1:length(folder)
img = imread(strcat('./train_KDEF/sad/', folder(i).name));

%%
cellSize = [8 8];
img = imresize(img,[400 300]);
% feature =[];
% wavelength = 4;
% orientation = [45 90];
% feature = gaborExtract(img, wavelength, orientation, [762 562]);
feature = extractHOGFeatures(img, 'CellSize', cellSize);

%%
label = 5;
[predicted_label, accuracy, ~] = svmpredict(double(label(1)), double(feature(1,:)), model);
% fprintf('%d of Predict= %s\n',i, cell2mat(faceLabel(predicted_label)));

end
%% 


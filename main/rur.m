%%
% Get label of face
% [faceLabel, musicLabel] = initalLabelSetting();
% load W_4_O_45_90_model.mat

img = startCam;
%%
feature =[];
wavelength = 4;
orientation = [45 90];
feature = gaborExtract(img, wavelength, orientation, [762 562]);

%%
label = 2;
[predicted_label, accuracy, ~] = svmpredict(double(label(1)), double(feature(1,:)), model);
fprintf('Predict= %s\n', cell2mat(faceLabel(predicted_label)));

%% 


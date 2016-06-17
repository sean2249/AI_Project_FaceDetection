% load('gabor_W_4_O_90_KDEFModel.mat')

test_folder = './train/disgust/';
label = 3;
folder = dir(test_folder);
for i=3:length(folder)
    img = imread(strcat(test_folder, folder(i).name));
%     imshow(img);
    wavelength = 8; orientation = 90; scale = 1/2;
    feature = gaborExtract(img, wavelength, orientation, scale);
    [output] = svmpredict(double(label), double(feature), model);
end

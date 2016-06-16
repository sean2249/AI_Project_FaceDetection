% I = imread('board.tif');
% I = imread('./train_KDEF/happy');
folder = dir('./train_KDEF/happy/*.jpg');
I = imread(strcat('./train_KDEF/happy/', folder(1).name));
I = rgb2gray(I);

wavelength = 2;
orientation = 0;
[mag, phase] = imgaborfilt(I, wavelength, orientation);
% mag = imgaussfilt(I);

% figure; imshow(I); title('Original');
% figure; imshow(mag, []); title('Gabor Magnitude');
% figure; imshow(phase, []); title('Gabor Phase');

for wavelength=1:10
    for orientation = 


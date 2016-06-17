function output = gaborExtract(img, wavelength, orientation, scaleRatio)
    img =imresize(img, scaleRatio)  ; 
    if size(img,3)==3
        img = rgb2gray(img);
    end
   [mag, ~] = imgaborfilt(img, wavelength, orientation);
   output = mag(:)';
end

%             scaleRatio = 1/2;
%             img = imresize(img,scaleRatio);
%             I = rgb2gray(img);
%             [mag, phase] = imgaborfilt(I, wavelength, orientation);
%             tmp = mag(:)';

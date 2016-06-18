function output = gaborExtract(img, wavelength, orientation, scaleRatio)
 % Default: wavelength = 4, orientation = 0, scaleRatio = 1
    if nargin < 4, scaleRatio = 1;end
    if nargin < 3, orientation = 0; end
    if nargin < 2, wavelength = 4; end

    img =imresize(img, scaleRatio)  ; 
    if size(img,3)==3
        img = rgb2gray(img);
    end
    
    output =[];
    for idxWav = 1:length(wavelength)
        for idxOri = 1:length(orientation)
            [mag,~] = imgaborfilt(img, wavelength(idxWav), orientation(idxOri));
            output = [output mag(:)'];
        end
    end
    
    



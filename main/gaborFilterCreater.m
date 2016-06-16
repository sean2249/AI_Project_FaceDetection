count = 1;
for wavelength = 2:3:10
   for orientation = 0:45:180
       g = gabor(wavelength, orientation);
       subplot(4,5,count); imshow( real(g(1).SpatialKernel), []);
       count = count +1;
   end
end
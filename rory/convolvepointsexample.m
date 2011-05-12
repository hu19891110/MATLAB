% example for convolvepoints.m
% 
% First you need to generate psf (just a small image 11x11 (should be odd numbers...) pixels in enough):
% eg:
psf = psfgen('lambda', 600, 'na', 1.2, 'pixelsize', 110, 'sizevec', [11 11], 'method', 'airy');

% your x and y are column vectors of coordiantes. If units of x and y are
% [nm], then set pixelsize = 1. If units of x and y are in pixels then set
% pixelsize = [size of the pixel in nm].
% Here I generate radnom coordinates of N=1000 points with values in nm (in the range 0:10000 nm) 
N = 500; 
pixelsize = 100; % in nanometers
x = 1e4*rand(N,1); % N random coordiantes (in nm) in the range 0:10000
y = 1e4*rand(N,1); 
np = 100 + 20*randn(N,1); % N random intesnities with mean 100 pixels and variance 50

% generate the image:
imout1 = convolvepoints(x,y,psf,np,pixelsize);
figure; 
imagesc(imout1)
title('imout1')
axis off
set (gca, 'DataAspectRatio',[1 1 1]);
colormap('gray')

% if all intensities are the same than you can pass np as a single number
% eg: 
np = 1000;
% this will crate an image where all psf have the same intesnity 1000;
imout2 = convolvepoints(x,y,psf,np,pixelsize);
figure; 
imagesc(imout2)
title('imout2')
axis off
set (gca, 'DataAspectRatio',[1 1 1]);
colormap('gray')

% if you don't pass np and pixelsize argumetn then defaulet values (np =1
% and pixelsize = 1 are used. This is for the case where all psf have same
% intensity and x and y are in pixels:
% eg: to create image with psf randomly scattered in an image 100x100
% pixels:
x = 100*rand(N,1); % in pixels
y = 100*rand(N,1);
imout3 = convolvepoints(x,y, psf);
% this is equivalent to: 
% convolvepoints(x,y, psf, 1,1);
figure; 
imagesc(imout3)
title('imout3')
axis off
set (gca, 'DataAspectRatio',[1 1 1]);
colormap('gray')


% This is for showing the location of the points...
[imout4, xout, yout] = convolvepoints(x,y, psf);
figure; 
imagesc(imout4)
hold on
scatter(xout, yout,'r')
title('imout4')
axis off
set (gca, 'DataAspectRatio',[1 1 1]);
colormap('gray')

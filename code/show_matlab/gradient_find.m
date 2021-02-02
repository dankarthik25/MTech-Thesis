% [dx,dy]=gradient_find(I, sigma) : smoothGradient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Local Function : smoothGradient
%
function [GX GY] = gradient_find(I, sigma)

% Create an even-length 1-D separable Derivative of Gaussian filter

% Determine filter length
filterLength = 8*ceil(sigma);
n = (filterLength - 1)/2;
x = -n:n;

% Create 1-D Gaussian Kernel
c = 1/(sqrt(2*pi)*sigma);
gaussKernel = c * exp(-(x.^2)/(2*sigma^2));

% Normalize to ensure kernel sums to one
gaussKernel = gaussKernel/sum(gaussKernel);

% Create 1-D Derivative of Gaussian Kernel
derivGaussKernel = gradient(gaussKernel);

% Normalize to ensure kernel sums to zero
negVals = derivGaussKernel < 0;
posVals = derivGaussKernel > 0;
derivGaussKernel(posVals) = derivGaussKernel(posVals)/sum(derivGaussKernel(posVals));
derivGaussKernel(negVals) = derivGaussKernel(negVals)/abs(sum(derivGaussKernel(negVals)));

% Compute smoothed numerical gradient of image I along x (horizontal)
% direction. GX corresponds to dG/dx, where G is the Gaussian Smoothed
% version of image I.
GX = double(imfilter(I, gaussKernel', 'conv', 'replicate'));
GX = double(imfilter(GX, derivGaussKernel, 'conv', 'replicate'));

% Compute smoothed numerical gradient of image I along y (vertical)
% direction. GY corresponds to dG/dy, where G is the Gaussian Smoothed
% version of image I.
GY = double(imfilter(I, gaussKernel, 'conv', 'replicate'));
GY  = double(imfilter(GY, derivGaussKernel', 'conv', 'replicate'));
% G = GX + GY *1j;



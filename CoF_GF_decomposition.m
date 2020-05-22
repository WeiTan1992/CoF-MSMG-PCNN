function [S,L,B] = CoF_GF_decomposition(PAN,I)

% GF
N = 4;
sigma = 10;
GaussianFilter = fspecial('gaussian',[2*N+1, 2*N+1],sigma);
Ig = imfilter(PAN,GaussianFilter,'conv');

% CoF
params.sigma_s=5;  % 5
params.sigma_oc=10;  % 10
Ic = CoOcurFilter(PAN,params);
S = PAN-Ic;
L = Ic-Ig;
B_uint8 = Ig;
B = im2double(B_uint8);
I = im2double(I);

eps = 0.1;
win_size = 11;
B = guided_filter(B,I,eps,win_size);
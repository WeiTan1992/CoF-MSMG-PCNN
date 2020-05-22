% ----------
% Author: Wei Tan
% E-mail: twtanwei1992@163.com
% Wei Tan, Pei Xiang, Jiajia Zhang, Huixin Zhou, and Hanlin Qin
% "Remote Sensing Image Fusion via Boundary Measured Dual-Channel PCNN in
% Multi-Scale Morphological Gradient Domain",
% IEEE Access, vol.8, pp.42540-42549, 2020
% doi: https://doi.org/10.1109/ACCESS.2020.2977299
% This code is only used for research.
% Please cite this publication if you use this code.

clear;clc;
close all;

path(path,'CoOccurFilter-master')

load 1_ms
load 1_pan

[MS,PAN] = imtransfer(cropped_im,cropped_gray);

M = imresize(MS,2,'bicubic');
M_hsv = rgb2hsv(M);
I = M_hsv(:,:,3);
I_uint8 = im2uint8(I);

[S,L,B] = CoF_GF_decomposition(PAN,I_uint8);

Fc = fusion_CoF_MSMG_PCNN(B,I);
S = im2double(S);
L = im2double(L);
Fi = Fc+S+L;
M_hsv(:,:,3) = Fi;
F_pr = hsv2rgb(M_hsv);
F = im2uint8(F_pr);

figure,imshow(MS);title('200*200 MS image')
figure,imshow(PAN);title('400*400 PAN image')
figure,imshow(F);title('Fused image')

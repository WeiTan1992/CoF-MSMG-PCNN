clear; close all;clc

% gray-image filtering
params.sigma_s=2;  % 5
params.sigma_oc=10;  % 10
img1=imread('images\RS_LandScape.png');
img1=double(img1(:,:,1));
img1f1=ImgFiltering(img1, 'gaussian', 5, 1.5);
img1f2=CoOcurFilter(img1, params);

% color-image filtering
params.sigma_s=7;
params.sigma_oc=10;
params.quant_level=64;
img2=imread('images\58060_rs.jpg');
img2=double(img2);
img2f1=ImgFiltering(img2, 'gaussian', 7, 1.5);
img2f2=CoOcurFilter(img2, params);

figure(1);set(gcf, 'position',[200 200 1200 600])
subplot(2,3,1);imagesc(img1,[0,255]);colormap(gray)
title('Original Gray Image')
subplot(2,3,2);imagesc(img1f1,[0,255]);colormap(gray)
title('Result of Gaussian Filtering')
subplot(2,3,3);imagesc(img1f2,[0,255]);colormap(gray)
title('Result of CoF Filtering')

subplot(2,3,4);imagesc(uint8(img2));
title('Original Color Image')
subplot(2,3,5);imagesc(uint8(img2f1));
title('Result of Gaussian Filtering')
subplot(2,3,6);imagesc(uint8(img2f2));
title('Result of CoF Filtering')



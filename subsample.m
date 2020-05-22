function r = subsample(im)
% 下采样
% im-输入图像，r-输出图像

[m,n,z] = size(im);
r = im(2:2:m,2:2:n,:);
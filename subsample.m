function r = subsample(im)
% �²���
% im-����ͼ��r-���ͼ��

[m,n,z] = size(im);
r = im(2:2:m,2:2:n,:);
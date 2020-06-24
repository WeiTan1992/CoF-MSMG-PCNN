function imgf=CoOcurFilterColor(img, params)

sigma_s=params.sigma_s;
sigma_oc=params.sigma_oc;
num_cluster=params.quant_level;
if (num_cluster<16)
    error('The cluster number is too small');
end

img_gd=GetGuidedImg(img, num_cluster);
coc_mat=GetCoOcurMat(img_gd, sigma_oc);

win_size=3*sigma_s;
win_halfsize=ceil(win_size/2);
win_size=win_halfsize*2+1;
[xx, yy]=meshgrid(-win_halfsize:win_halfsize, -win_halfsize:win_halfsize);
w_s=exp(-(xx.^2+yy.^2)/(2*sigma_s*sigma_s));
w_s=w_s(:);

img_pad=padarray(img, [win_halfsize, win_halfsize, 0], 0, 'both');
img_gd_pad=padarray(img_gd, [win_halfsize, win_halfsize], 0, 'both');
[nrow, ncol, nchl]=size(img_pad);
imgf=img;
for i=1:(nrow-win_size+1)
    for j=1:(ncol-win_size+1)
         img_sub=img_pad(i:i+win_size-1, j:j+win_size-1,:);       
         img_gd_sub=img_gd_pad(i:i+win_size-1, j:j+win_size-1);
         w_oc=coc_mat(img_gd_sub(:)+1,img_gd_sub(win_halfsize+1, win_halfsize+1)+1);
         w=w_oc.*w_s;
         [nr_sub, nc_sub, nd_sub]=size(img_sub);
         img_sub=reshape(img_sub, [nr_sub*nc_sub, nd_sub]);
         wsum=sum(w)+eps;
         for d=1:nchl
             imgf(i,j,d)=sum(w.*img_sub(:,d))/wsum;
         end         
    end
end


function img_gd=GetGuidedImg(img, ncluster)
[nrow, ncol, nchl]=size(img);
npixel=nrow*ncol;
img_data=reshape(double(img),[nrow*ncol, nchl]);
img_data=img_data/(mean(img_data(:))+eps);
[idx, c]=kmeans(img_data,ncluster, 'MaxIter', 10);
img_gd=int32(reshape(idx-1,[nrow, ncol]));








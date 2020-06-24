function imgf=CoOcurFilterGray(img, params)

sigma_s=params.sigma_s;
sigma_oc=params.sigma_oc;
if isfloat(img)
    img=int32(round(img));
end

coc_mat=GetCoOcurMat(img, sigma_oc);

win_size=3*sigma_s;
win_halfsize=ceil(win_size/2);
win_size=win_halfsize*2+1;
[xx, yy]=meshgrid(-win_halfsize:win_halfsize, -win_halfsize:win_halfsize);
w_s=exp(-(xx.^2+yy.^2)/(2*sigma_s*sigma_s));
w_s=w_s(:);

img_pad=padarray(img, [win_halfsize, win_halfsize], 0, 'both');
[nrow, ncol]=size(img_pad);
imgf=img;
for i=1:(nrow-win_size+1)
    for j=1:(ncol-win_size+1)
         img_sub=img_pad(i:i+win_size-1, j:j+win_size-1);
         w_oc=coc_mat(img_sub(:)+1,img_sub(win_halfsize+1, win_halfsize+1)+1);
         w=w_oc.*w_s;
         imgf(i,j)=sum(double(img_sub(:)).*w)/(sum(w)+eps);        
    end
end















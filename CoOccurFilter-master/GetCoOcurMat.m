function coc_mat=GetCoOcurMat(img, sigma_oc)
[nrow, ncol]=size(img);
win_size=3*sigma_oc;
win_size=ceil(win_size/2);
[xx, yy]=meshgrid(0:win_size, 0:win_size);
ws=exp(-(xx.^2+yy.^2)/(2*sigma_oc*sigma_oc));

img_max=max(img(:));
val_range=img_max+1;
coc_mat=zeros(val_range,val_range);
h=zeros(1, val_range);
img=img+1;

for i=1:nrow
    for j=1:ncol
        h(img(i,j))=h(img(i,j))+1;
        for di=i:min(i+win_size, nrow)
            for dj=j:min(j+win_size, ncol)
                coc_mat(img(i,j), img(di, dj))=coc_mat(img(i,j), img(di, dj))+ws(di-i+1, dj-j+1);
                coc_mat(img(di,dj), img(i, j))=coc_mat(img(di,dj), img(i, j))+ws(di-i+1, dj-j+1);
            end
        end
        coc_mat(img(i,j),img(i,j))=coc_mat(img(i,j),img(i,j))-2;
    end
end
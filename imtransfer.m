function [I_MS,I_PAN] = imtransfer(cropped_im,cropped_pan)

MS = cropped_im(:,:,1:3);
I_MS = subsample(MS);
% I_MS = double(I_MS)/255;

PAN = cropped_pan;
I_PAN = subsample(PAN);
% I_PAN = double(I_PAN)/255;
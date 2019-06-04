function compare(oriPath,afterPath)
%相减和相除来比较两张图的差异
%其中相除是

oriImg=getDumpMapping(oriPath);
oriImg=toUintImg(oriImg);
afterImg=getDumpMapping(afterPath);
afterImg=toUintImg(afterImg);
temp=zeros(size(oriImg));
temp(1:size(afterImg,1),1:size(afterImg,2),:)=afterImg;
afterImg=temp;

subMat=double(oriImg)-double(afterImg);

subplot(2,3,1);
mesh(double(subMat(:,:,1)));
subplot(2,3,2);
mesh(double(subMat(:,:,2)));
subplot(2,3,3);
mesh(double(subMat(:,:,3)));

% subplot(1,2,1);
% imshow(subMat);
% 
divMat1=double(oriImg(:,:,1))./double(afterImg(:,:,1));
subplot(2,3,4);
imshow(divMat1);
divMat2=double(oriImg(:,:,2))./double(afterImg(:,:,2));
subplot(2,3,5);
imshow(divMat2);
divMat3=double(oriImg(:,:,3))./double(afterImg(:,:,3));
subplot(2,3,6);
imshow(divMat3);

end
function sharpened=sharpen(oriPath)
% % ��
% % Laplacian����
% 
% I = getDumpMapping(oriPath);
% H = fspecial('laplacian',0);
% 
% g = imfilter(I,H,'replicate');
% sharpened=I-g;
% sharpened=toNormalImg(sharpened);
% 
% imshow(sharpened);
% path=['LapShap_',oriPath];
% imwrite(sharpened,path);

% % ��
% % YSobel����
% 
% I = getDumpMapping(oriPath);
% H = [-1,0,1;-2,0,+2;-1,0,1];
% 
% g = imfilter(I,H,'replicate');
% sharpened=I-g;
% sharpened=toNormalImg(sharpened);
% 
% imshow(sharpened);
% path=['SobYShap_',oriPath];
% imwrite(sharpened,path);

% % ��
% % CannyZ����
% 
% I = getDumpMapping(oriPath);
% 
% g3 = edge(I(:,:,3),'Canny');
% 
% sharpened(:,:,1)=I(:,:,1);
% sharpened(:,:,2)=I(:,:,2);
% sharpened(:,:,3)=I(:,:,3)-g3;
% sharpened=toNormalImg(sharpened);
% 
% imshow(sharpened);
% path=['CanShapZ_',oriPath];
% imwrite(sharpened,path);

% ��
% LaplacianZ����

I = getDumpMapping(oriPath);
H = fspecial('laplacian');

g3 = imfilter(I(:,:,3),H,'replicate');

sharpened(:,:,1)=I(:,:,1);
sharpened(:,:,2)=I(:,:,2);
sharpened(:,:,3)=I(:,:,3)+g3;
sharpened=toNormalImg(sharpened);

imshow(sharpened);
path=['LapShapZ_',oriPath];
imwrite(sharpened,path);

end
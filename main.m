imageName='cat';

%计算光源
lightPos=calLight();

% %读取光源
% lightFile = fopen('psmImages/lights.txt', 'r');
% pos = textscan(lightFile, '%f %f %f', 'HeaderLines', 1, 'Delimiter', ' ');
% lightPos = [pos{1} pos{2} pos{3}];
% fclose(lightFile);

%计算法线和反射率rho
[normals,rho]=calNormals(imageName,lightPos);

% %显示法线图
% show_surfNorm(normals, 4);
% pause;

% RGB显示法线图
% imshow(N);
% pause;
% 
% %显示反射率图
% imshow(rho);
% pause;

%读取遮罩
mask=tga_read_image(['psmImages\cat\cat.mask.tga']);
mask=uint8(mask&1);
mask=rgb2gray(mask);

%计算深度
depths=calDepth(N,mask);

%显示深度图
minD = min(depths(~isnan(depths)));
maxD = max(depths(~isnan(depths)));
depths2D=(depths-minD)/(maxD-minD)*255;
imshow(uint8(depths2D));
pause;
surfl(depths);

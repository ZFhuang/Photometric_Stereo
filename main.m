imageName='cat';

%�����Դ
lightPos=calLight();

% %��ȡ��Դ
% lightFile = fopen('psmImages/lights.txt', 'r');
% pos = textscan(lightFile, '%f %f %f', 'HeaderLines', 1, 'Delimiter', ' ');
% lightPos = [pos{1} pos{2} pos{3}];
% fclose(lightFile);

%���㷨�ߺͷ�����rho
[normals,rho]=calNormals(imageName,lightPos);

% %��ʾ����ͼ
% show_surfNorm(normals, 4);
% pause;

% RGB��ʾ����ͼ
% imshow(N);
% pause;
% 
% %��ʾ������ͼ
% imshow(rho);
% pause;

%��ȡ����
mask=tga_read_image(['psmImages\cat\cat.mask.tga']);
mask=uint8(mask&1);
mask=rgb2gray(mask);

%�������
depths=calDepth(N,mask);

%��ʾ���ͼ
minD = min(depths(~isnan(depths)));
maxD = max(depths(~isnan(depths)));
depths2D=(depths-minD)/(maxD-minD)*255;
imshow(uint8(depths2D));
pause;
surfl(depths);

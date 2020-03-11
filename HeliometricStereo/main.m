lightsFolder='Resources/Lights';
objectFolder='Resources/Apollo';
endIdx=16;

disp('��ʼ��Դ����');
%�����Դ
lightPos=calLight(lightsFolder,endIdx);
%�����Դ
save([lightsFolder,'/lightPos.txt'],'lightPos','-ascii');
%��ȡ��Դ
lightPos = load([lightsFolder,'/lightPos.txt'],'-ascii');
disp('��Դ�������');

%���㷨�ߺͷ�����rho
disp('��ʼ���㷨�ߺͷ�����');
[normals,rho]=calNormals(objectFolder,endIdx,lightPos);
disp('���㷨�ߺͷ��������');

%��ʾ����ͼ
show_surfNorm(normals, 4);
pause;

%RGB��ʾ����ͼ
imshow(toNormalImg(normals));
pause;

%��ʾ������ͼ
imshow(rho);
pause;

%�������ͼ
depths = calDepth(normals, objectFolder);

%��ʾ���ͼ
disp('��ʾ���');
minD = min(depths(~isnan(depths)));
maxD = max(depths(~isnan(depths)));
depths2D=(depths-minD)/(maxD-minD)*255;
imshow(uint8(depths2D));
pause;
surfl(depths);
pause;

% %��������ͼ
% mask=imread([imageFolder,'ApolloMask.png']);
% mask=rgb2gray(mask);
% % imshow(mask);
% 
% height=size(mask,1);
% width=size(mask,2);
% 
% for i=1:height
%     for j=1:width
%         if mask(i,j)~=0
%             mask(i,j)=255;
%         end
%     end
% end
% 
% imwrite(mask,'ApolloMask2.png');
% imshow(mask);

% lightsFolder='Resources/Lights';
% objectFolder='Resources/Apollo';
% endIdx=4;
% 
% disp('��ʼ��Դ����');
% %�����Դ
% lightPos=calLight(lightsFolder,endIdx);
% %�����Դ
% save([lightsFolder,'/lightPos.txt'],'lightPos','-ascii');
% %��ȡ��Դ
% lightPos = load([lightsFolder,'/lightPos.txt'],'-ascii');
% disp('��Դ�������');
% 
% %���㷨�ߺͷ�����rho
% disp('��ʼ���㷨�ߺͷ�����');
% [normals,rho]=calNormals(objectFolder,endIdx,lightPos);
% disp('���㷨�ߺͷ��������');
% 
% %��ʾ����ͼ
% figure;
% show_surfNorm(normals, 4);
% 
% %RGB��ʾ����ͼ
% figure;
% imshow(toNormalImg(normals));
% 
% %��ʾ������ͼ
% figure;
% imshow(rho);
% 
% %�������ͼ
% depths = calDepth(normals, objectFolder);

%��ʾ���ͼ
disp('��ʾ���');
minD = min(depths(~isnan(depths)));
maxD = max(depths(~isnan(depths)));
depths2D=(depths-minD)/(maxD-minD)*255;
figure;
imshow(uint8(depths2D));
% pause;
figure;
s=surfl(depths);
s.EdgeColor = 'none';
% pause;

% %���ű���������һ���ؽ������в���
% 
% %����������������������������������������������������������������������������
% %�����ļ���ָ�����ļ���������ָ��
% 
% lightsFolder='Resources/Lights';
% objectFolder='Resources/Apollo';
% endIdx=6;
% 
% %����������������������������������������������������������������������������
% %�����Դ��Ϣ
% 
% disp('��ʼ��Դ����');
% % %�ñ궨������Դ
% % lightPos=calLight(lightsFolder,endIdx);
% %�õ�����Ϣ�����Դ
% lightVec=calLightSun(lightsFolder,endIdx);
% %�����Դ
% save([lightsFolder,'/lightPos.txt'],'lightVec','-ascii');
% %��ȡ��Դ
% lightVec = load([lightsFolder,'/lightPos.txt'],'-ascii');
% disp('��Դ�������');
% 
% %����������������������������������������������������������������������������
% %��ԭ���淨�߲���ʾ
% 
% %���㷨�ߺͷ�����rho
% disp('��ʼ���㷨�ߺͷ�����');
% [normals,rho]=calNormals(objectFolder,endIdx,lightVec);
% disp('���㷨�ߺͷ��������');
% 
% %��ʾ����ͼ
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
% %����������������������������������������������������������������������������
% %�ӷ��߻�ԭ���������Ϣ
% 
% %�������ͼ
% disp('��ʼ�������');
% depths = calDepth(normals, objectFolder);
% disp('��ʼ��ȼ������');
% 
% %��ʾ���ͼ
% disp('��������');
% disp('��ʾ���');
% minD = min(depths(~isnan(depths)));
% maxD = max(depths(~isnan(depths)));
% depths2D=(depths-minD)/(maxD-minD)*255;
% figure;
% imshow(uint8(depths2D));
% % pause;
% figure;
%����ʱ��Ҫ�������Ϣ����ת�ò���������ʾ
s=surfl(depths');
s.EdgeColor = 'none';

%����Ϊstl�ļ�
surf2stl('Outputs/outputSTL.stl',s.XData,s.YData,s.ZData);

% pause;

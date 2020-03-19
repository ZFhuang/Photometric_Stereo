function lightVec=calLightSun(imageFolder,endIdx)
%function lightVec=calLightSun(imageFolder,endIdx)
%�����ļ�����ʱ�䣬��γ��������ǻ��һϵ��̫�����շ�������
%��Ҫʹ��sunVec.m
%
%imageFolder:   ͼƬ�ļ��У�Ҳ�ǲ����ļ�'suns.txt'���ڵ��ļ���
%               �ļ���'%f�� %f�� %f�� %fʱ %f�� %f���� %fγ�� %f���� %f���'
%endIdx:        ���ڿ������з�Χ����1��endIdx
%
%example:       lightVec=calLightSun('Resources/Lights',6);

%����������������������������������������������������������������������������
%��ȡ�ļ�����

f = fopen([imageFolder,'/suns.txt'], 'r');
s = textscan(f, '%f %f %f %f %f %f %f %f %f', ...
'HeaderLines', 0, 'Delimiter', ' ');
fclose(f);
%���η�������
sun = [s{1},s{2},s{3},s{4},s{5},s{6},s{7},s{8},s{9}];

%����������������������������������������������������������������������������
%����Ӧ��תΪ��������

lightVec=zeros(endIdx,3);
for i=1:endIdx
    %ƴ��datetime
    time=datetime(sun(i,1), sun(i,2), sun(i,3), sun(i,4), sun(i,5), 0);
    %���ò�������
    light=sunVec(time,sun(i,6),sun(i,7),sun(i,8),sun(i,9));
    lightVec(i,:)=light;
end
end
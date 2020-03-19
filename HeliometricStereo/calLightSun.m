function lightVec=calLightSun(imageFolder,endIdx)
%function lightVec=calLightSun(imageFolder,endIdx)
%按照文件所给时间，经纬，方向，倾角获得一系列太阳光照方向向量
%需要使用sunVec.m
%
%imageFolder:   图片文件夹，也是参数文件'suns.txt'所在的文件夹
%               文件是'%f年 %f月 %f日 %f时 %f分 %f经度 %f纬度 %f方向 %f倾角'
%endIdx:        用于控制序列范围，从1到endIdx
%
%example:       lightVec=calLightSun('Resources/Lights',6);

%——————————————————————————————————————
%读取文件内容

f = fopen([imageFolder,'/suns.txt'], 'r');
s = textscan(f, '%f %f %f %f %f %f %f %f %f', ...
'HeaderLines', 0, 'Delimiter', ' ');
fclose(f);
%依次放入数组
sun = [s{1},s{2},s{3},s{4},s{5},s{6},s{7},s{8},s{9}];

%——————————————————————————————————————
%将对应项转为参数计算

lightVec=zeros(endIdx,3);
for i=1:endIdx
    %拼接datetime
    time=datetime(sun(i,1), sun(i,2), sun(i,3), sun(i,4), sun(i,5), 0);
    %调用参数计算
    light=sunVec(time,sun(i,6),sun(i,7),sun(i,8),sun(i,9));
    lightVec(i,:)=light;
end
end
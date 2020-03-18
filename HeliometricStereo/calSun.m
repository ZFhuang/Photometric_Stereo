function lightVec=calSun(time,zone,longitude,latitude,angle)
%function lightVec=calSun(date,time,GMT,longitude,latitude)
%输入地理位置等信息，返回相机直角坐标系下的太阳光照单位方向向量
%
%参数:
%time:      时间，string型，格式为'yyyy/mm/dd/hh/mm'，
%           如2019年12月27日9点9分=2019/12/27/09/09
%zone:      时区，输入以GMT为偏移的时区，如：东八区 = +8
%longitude: 经度，double型
%latitude:  纬度，double型
%angle:     拍摄时的相机角度，以正北为0度
%
%示例: lightVec=calSun('2019/12/27/9/9',8,113.555,22.315,-60);

%——————————————————————————————————————
%计算太阳高度角theta和方位角phi
%解析time字符串

%——————————————————————————————————————

%转为相机坐标系
%测试数据来自https://www.hko.gov.hk/tc/gts/astronomy/SunPathDay3_ue.htm
%测试图片IMG_20191227_095912，9.59分拍摄
%theta=23.5
%phi=129.8

theta=44.6;
phi=180.8;
%进行拍摄方位角偏移
phi=phi-angle;

%转为直角坐标系,此处令r=1
x=sin(theta)*cos(phi);
y=sin(theta)*sin(phi);
%z写为单位向量形式
z=sqrt(1-x*x-y*y);
lightVec=[x,y,z];
end
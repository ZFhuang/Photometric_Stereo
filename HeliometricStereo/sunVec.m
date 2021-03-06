function light=sunVec(time,longitude,latitude,angleHor,angleVer)
%function lightVec=sunVec(date,time,GMT,longitude,latitude)
%输入地理位置等信息，返回相机直角坐标系下的太阳光照单位方向向量
%
%time:      时间，datetime型，需要有年月日小时分钟和时区，
%           如 time=datetime(2019, 12, 27, 9, 59, 0);
%              time.TimeZone='Asia/Hong_Kong';
%longitude: 经度，double型
%latitude:  纬度，double型
%angleHor:  拍摄时的相机水平角度,单位是度，即零方位角，以正北为0度，顺时针为正
%angleVer:  拍摄时的相机垂直角度,单位是度，以垂直向上为0度，向前倾倒为正
%
%example:   light=sunVec(time,113.9859,22.5304,-46,25);

%——————————————————————————————————————
%计算从元旦起的天数n

%初始化元旦
firstTime=datetime(time.Year,1,1,0,0,0);
firstTime.TimeZone=time.TimeZone;
%计算差值（天数）
n=caldiff([firstTime,time],'days');
%转为数字
n=caldays(n);

%——————————————————————————————————————
%计算真太阳时T(单位为带有小数的小时)

%先计算平太阳时t
%北京时间（记录的时间）
timeBJ=time.Hour+time.Minute/60;
%北京经度
longitudeBJ=120;
t=timeBJ-4*(longitudeBJ-longitude)/60;
%修正时差E(单位分钟,需要改为单位小时)
Q=2*pi*n/365;
E=0.0172+0.4281*cos(Q)-7.3515*sin(Q)-3.3495*cos(2*Q)-9.3619*sin(2*Q);
E=E/60;
%得到真太阳时T
T=t+E;

%——————————————————————————————————————
%计算时角omega

omega=(12-T)*(pi/12);

%——————————————————————————————————————
%计算赤纬角delta

delta=-23.45*(pi/180)*cos((2*pi/365)*(n+10));

%——————————————————————————————————————
%计算高度角theta

%经度转为弧度
latitude=latitude*(pi/180);
%计算出sin形式再反解
sinTheta=sin(latitude)*sin(delta)+cos(latitude)*cos(delta)*cos(omega);
theta=asin(sinTheta);

%——————————————————————————————————————
%计算方位角phi

cosPhi=(sin(theta)*sin(latitude)-sin(delta))/(cos(theta)*cos(latitude));
if omega>0
    phi=pi-acos(cosPhi);
else
    phi=pi+acos(cosPhi);
end

%——————————————————————————————————————
%转为相机坐标系

%测试数据来自https://www.osgeo.cn/app/s1904
%测试图片IMG_20191227_095912，9:59拍摄
%东经113.9859，北纬22.5304
disp(['高度角: ',num2str(theta/(pi/180))]);
disp(['方位角: ',num2str(phi/(pi/180))]);

%进行相机零角偏移
phi=phi-angleHor*(pi/180);
%将高度角转为天顶角
theta=pi/2-theta;
%进行相机垂角偏移
theta=theta+angleVer*(pi/180);

disp(['调整后的天顶角: ',num2str(theta/(pi/180))]);
disp(['调整后的方位角: ',num2str(phi/(pi/180))]);

%转为直角坐标系,此处令r=1,即单位向量
x=sin(theta)*cos(phi);
y=sin(theta)*sin(phi);
z=cos(theta);
%注意相机坐标系与平时用的直角坐标系是不同的
light=[y,z,-x];
%再化一次单位向量防止误差
light=light/norm(light);
end
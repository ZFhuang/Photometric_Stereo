function light=sunVec(time,longitude,latitude,angleHor,angleVer)
%function lightVec=sunVec(date,time,GMT,longitude,latitude)
%�������λ�õ���Ϣ���������ֱ������ϵ�µ�̫�����յ�λ��������
%
%time:      ʱ�䣬datetime�ͣ���Ҫ��������Сʱ���Ӻ�ʱ����
%           �� time=datetime(2019, 12, 27, 9, 59, 0);
%              time.TimeZone='Asia/Hong_Kong';
%longitude: ���ȣ�double��
%latitude:  γ�ȣ�double��
%angleHor:  ����ʱ�����ˮƽ�Ƕ�,��λ�Ƕȣ����㷽λ�ǣ�������Ϊ0�ȣ�˳ʱ��Ϊ��
%angleVer:  ����ʱ�������ֱ�Ƕ�,��λ�Ƕȣ��Դ�ֱ����Ϊ0�ȣ���ǰ�㵹Ϊ��
%
%example:   light=sunVec(time,113.9859,22.5304,-46,25);

%����������������������������������������������������������������������������
%�����Ԫ���������n

%��ʼ��Ԫ��
firstTime=datetime(time.Year,1,1,0,0,0);
firstTime.TimeZone=time.TimeZone;
%�����ֵ��������
n=caldiff([firstTime,time],'days');
%תΪ����
n=caldays(n);

%����������������������������������������������������������������������������
%������̫��ʱT(��λΪ����С����Сʱ)

%�ȼ���ƽ̫��ʱt
%����ʱ�䣨��¼��ʱ�䣩
timeBJ=time.Hour+time.Minute/60;
%��������
longitudeBJ=120;
t=timeBJ-4*(longitudeBJ-longitude)/60;
%����ʱ��E(��λ����,��Ҫ��Ϊ��λСʱ)
Q=2*pi*n/365;
E=0.0172+0.4281*cos(Q)-7.3515*sin(Q)-3.3495*cos(2*Q)-9.3619*sin(2*Q);
E=E/60;
%�õ���̫��ʱT
T=t+E;

%����������������������������������������������������������������������������
%����ʱ��omega

omega=(12-T)*(pi/12);

%����������������������������������������������������������������������������
%�����γ��delta

delta=-23.45*(pi/180)*cos((2*pi/365)*(n+10));

%����������������������������������������������������������������������������
%����߶Ƚ�theta

%����תΪ����
latitude=latitude*(pi/180);
%�����sin��ʽ�ٷ���
sinTheta=sin(latitude)*sin(delta)+cos(latitude)*cos(delta)*cos(omega);
theta=asin(sinTheta);

%����������������������������������������������������������������������������
%���㷽λ��phi

cosPhi=(sin(theta)*sin(latitude)-sin(delta))/(cos(theta)*cos(latitude));
if omega>0
    phi=pi-acos(cosPhi);
else
    phi=pi+acos(cosPhi);
end

%����������������������������������������������������������������������������
%תΪ�������ϵ

%������������https://www.osgeo.cn/app/s1904
%����ͼƬIMG_20191227_095912��9:59����
%����113.9859����γ22.5304
disp(['�߶Ƚ�: ',num2str(theta/(pi/180))]);
disp(['��λ��: ',num2str(phi/(pi/180))]);

%����������ƫ��
phi=phi-angleHor*(pi/180);
%���߶Ƚ�תΪ�춥��
theta=pi/2-theta;
%�����������ƫ��
theta=theta+angleVer*(pi/180);

disp(['��������춥��: ',num2str(theta/(pi/180))]);
disp(['������ķ�λ��: ',num2str(phi/(pi/180))]);

%תΪֱ������ϵ,�˴���r=1,����λ����
x=sin(theta)*cos(phi);
y=sin(theta)*sin(phi);
z=cos(theta);
%ע���������ϵ��ƽʱ�õ�ֱ������ϵ�ǲ�ͬ��
light=[y,z,-x];
%�ٻ�һ�ε�λ������ֹ���
light=light/norm(light);
end
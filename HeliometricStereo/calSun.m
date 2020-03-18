function lightVec=calSun(time,zone,longitude,latitude,angle)
%function lightVec=calSun(date,time,GMT,longitude,latitude)
%�������λ�õ���Ϣ���������ֱ������ϵ�µ�̫�����յ�λ��������
%
%����:
%time:      ʱ�䣬string�ͣ���ʽΪ'yyyy/mm/dd/hh/mm'��
%           ��2019��12��27��9��9��=2019/12/27/09/09
%zone:      ʱ����������GMTΪƫ�Ƶ�ʱ�����磺������ = +8
%longitude: ���ȣ�double��
%latitude:  γ�ȣ�double��
%angle:     ����ʱ������Ƕȣ�������Ϊ0��
%
%ʾ��: lightVec=calSun('2019/12/27/9/9',8,113.555,22.315,-60);

%����������������������������������������������������������������������������
%����̫���߶Ƚ�theta�ͷ�λ��phi
%����time�ַ���

%����������������������������������������������������������������������������

%תΪ�������ϵ
%������������https://www.hko.gov.hk/tc/gts/astronomy/SunPathDay3_ue.htm
%����ͼƬIMG_20191227_095912��9.59������
%theta=23.5
%phi=129.8

theta=44.6;
phi=180.8;
%�������㷽λ��ƫ��
phi=phi-angle;

%תΪֱ������ϵ,�˴���r=1
x=sin(theta)*cos(phi);
y=sin(theta)*sin(phi);
%zдΪ��λ������ʽ
z=sqrt(1-x*x-y*y);
lightVec=[x,y,z];
end
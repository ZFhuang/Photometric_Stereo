function lightVec=calLight(imageFolder,endIdx)
%function lightVec=calLight(imageFolder,endIdx)
%����ͼƬ�еı궨������Դ����
%
%imageFolder:   ͼƬ�ļ���
%endIdx:        ���ڿ������з�Χ����1��endIdx
%
%example:       lightVec=calLight('Resources/Lights',6);

%����������������������������������������������������������������������������
%��ȡ�����ļ�������궨��Բ��λ��

disp('��������');
lightVec=zeros(endIdx,3);

%��ȡ����
maskImg=imread([imageFolder,'/mask.png']);
maskImg=maskImg(:,:,1);

% imshow(maskImg);
% pause;

%����Բ��
disp('��ʼ����Բ��');
height=size(maskImg,1);
width=size(maskImg,2);

count=0;
centH=0;
centW=0;

for h=1:height
    for w=1:width
        if maskImg(h,w)>200
            maskImg(h,w)=1;
            count=count+1;
            centH=centH+h;
            centW=centW+w;
        else
            maskImg(h,w)=0;
        end
    end
end

% %��������״̬
% imshow(maskImg);
% Img=imread([imageFolder,'/',int2str(1),'.bmp']);
% Img=Img.*maskImg;
% imshow(Img);

%����������������������������������������������������������������������������
%����궨��뾶

%ƽ������Բ�����ص�λ�õõ�Բ��
centroid=[centH/count,centW/count];
%���������뾶
R=sqrt(count/pi);

%����뾶
%disp(R);

%����������������������������������������������������������������������������
%����߹�㲢��������߹���Ӧ�Ĺ�Դ����

disp('��ʼ����߹��');
%��������ͼ��
for i=1:endIdx
    %��ȡ��ֻȡ����һͨ����ʹ��
    Img=imread([imageFolder,'/',int2str(i),'.bmp']);
    Img=Img(:,:,3);
    %��������
    Img=Img.*maskImg;
    
    %����߹��
    count=0;
    centH=0;
    centW=0;
    
    for h=1:height
        for w=1:width
            if Img(h,w)>128
                count=count+1;
                centH=centH+h;
                centW=centW+w;
            else
            end
        end
    end
        
    %ƽ���õ��߹�����
    highlight=[centH/count,centW/count];
    
    %����߹ⷨ��
    x=highlight(1)-centroid(1);
    y=highlight(2)-centroid(2);
    z=sqrt(R^2-x^2-y^2);
    %ע���������ϵ��ƽʱ�õ�ֱ������ϵ�ǲ�ͬ��
    normal=[y,-x,z];
    %��λ��
    N=normal./R;
    
    %�ӵ�����,����ָ��߹��Ƚ����ѣ�����ֱ�ӳ�ǰ
    A=[0,0,1];
    %�����Դ�������ɻ�ͼ��
    lightVec(i,:)=2*(N*A')*N-A;
end
end
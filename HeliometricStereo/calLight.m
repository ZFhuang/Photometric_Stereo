function lightPos=calLight(imageFolder,endIdx)
%imageFolder�ǹ�Դ�궨����Ƭ���ڵ��ļ���
%endIdx�����һ���ļ�����ţ���1��ʼ

disp('��������');
lightPos=zeros(endIdx,3);

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
% Img=imread([imageFolder,'/',int2str(1),'.bmp']);
% Img=Img.*maskImg;
% imshow(Img);

%ƽ������Բ�����ص�λ�õõ�Բ��
centroid=[centH/count,centW/count];

%���������뾶
R=sqrt(count/pi);

%�õ��뾶
%disp(R);

disp('��ʼ����߹��');
%��������ͼ��
for i=1:endIdx
    %��ȡ��ֻȡ����һͨ����ʹ��
    Img=imread([imageFolder,'/',int2str(i),'.bmp']);
    Img=Img(:,:,2);
    %��������
    Img=Img.*maskImg;
    imshow(Img);
    
    %����߹��
    count=0;
    centH=0;
    centW=0;
    
    for h=1:height
        for w=1:width
            if Img(h,w)>130
                count=count+1;
                centH=centH+h;
                centW=centW+w;
            end
        end
    end
    
    %ƽ���õ��߹�����
    highlight=[centH/count,centW/count];
    
    %����߹ⷨ��
    x=highlight(1)-centroid(1);
    y=highlight(2)-centroid(2);
    z=sqrt(R^2-x^2-y^2);
    normal=[x,y,z];
    %��λ��
    N=normal./R;
    
    %��ʽ(??)�õ����
    A=[0,0,1];
    lightPos(i,:)=2*(N*A')*N-A;
end

%����Ϊʲô
lightPos(:,1)=-lightPos(:,1); %���еõ�����git�ϵ�Ч���������������µ�Ч��
temp=lightPos(:,1);
lightPos(:,1)=lightPos(:,2);
lightPos(:,2)=temp;
end
function lightPos=calLight
lightPos=zeros(12,3);
A=[0,0,1];

%��ȡ����
[maskImg,maskMap]=tga_read_image(['psmImages\chrome\chrome.mask.tga']);
%imshow(maskImg,maskMap);
maskImg=rgb2gray(maskImg);
%pause;

%����Բ��
height=size(maskImg,1);
width=size(maskImg,2);

count=0;
centH=0;
centW=0;

for h=1:height
    for w=1:width
        if maskImg(h,w)>0
            count=count+1;
            centH=centH+h;
            centW=centW+w;
        end
    end
end

%ƽ������Բ�����ص�λ�õõ�Բ��
centroid=[centH/count,centW/count];

%���������뾶
R=sqrt(count/pi);

%�õ��뾶
%disp(R);

%��������ͼ��
maskImg=uint8(maskImg&1);
for i=0:11
    [Img,Map]=tga_read_image(['psmImages\chrome\chrome.',mat2str(i),'.tga']);
    Img=rgb2gray(Img);
    Img=Img.*maskImg;
    %imshow(Img,Map);
    %pause;
    
    %����߹��
    count=0;
    centH=0;
    centW=0;
    
    for h=1:height
        for w=1:width
            if Img(h,w)>100
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
    lightPos(i+1,:)=2*(N*A')*N-A;
end

%����Ϊʲô
%lightPos(:,1)=-lightPos(:,1); %���еõ�����git�ϵ�Ч���������������µ�Ч��
temp=lightPos(:,1);
lightPos(:,1)=lightPos(:,2);
lightPos(:,2)=temp;
end
function lightPos=calLight
lightPos=zeros(12,3);
A=[0,0,1];

%读取遮罩
[maskImg,maskMap]=tga_read_image(['psmImages\chrome\chrome.mask.tga']);
%imshow(maskImg,maskMap);
maskImg=rgb2gray(maskImg);
%pause;

%计算圆心
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

%平均所有圆上像素的位置得到圆心
centroid=[centH/count,centW/count];

%用面积计算半径
R=sqrt(count/pi);

%得到半径
%disp(R);

%遍历反光图像
maskImg=uint8(maskImg&1);
for i=0:11
    [Img,Map]=tga_read_image(['psmImages\chrome\chrome.',mat2str(i),'.tga']);
    Img=rgb2gray(Img);
    Img=Img.*maskImg;
    %imshow(Img,Map);
    %pause;
    
    %计算高光点
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
    
    %平均得到高光中心
    highlight=[centH/count,centW/count];
    
    %计算高光法线
    x=highlight(1)-centroid(1);
    y=highlight(2)-centroid(2);
    z=sqrt(R^2-x^2-y^2);
    normal=[x,y,z];
    %单位化
    N=normal./R;
    
    %公式(??)得到结果
    lightPos(i+1,:)=2*(N*A')*N-A;
end

%可是为什么
%lightPos(:,1)=-lightPos(:,1); %这行得到类似git上的效果，不加则是文章的效果
temp=lightPos(:,1);
lightPos(:,1)=lightPos(:,2);
lightPos(:,2)=temp;
end
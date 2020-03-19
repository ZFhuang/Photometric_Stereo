function lightVec=calLight(imageFolder,endIdx)
%function lightVec=calLight(imageFolder,endIdx)
%利用图片中的标定球计算光源方向
%
%imageFolder:   图片文件夹
%endIdx:        用于控制序列范围，从1到endIdx
%
%example:       lightVec=calLight('Resources/Lights',6);

%——————————————————————————————————————
%读取遮罩文件并计算标定球圆心位置

disp('————');
lightVec=zeros(endIdx,3);

%读取遮罩
maskImg=imread([imageFolder,'/mask.png']);
maskImg=maskImg(:,:,1);

% imshow(maskImg);
% pause;

%计算圆心
disp('开始计算圆心');
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

% %测试掩码状态
% imshow(maskImg);
% Img=imread([imageFolder,'/',int2str(1),'.bmp']);
% Img=Img.*maskImg;
% imshow(Img);

%——————————————————————————————————————
%计算标定球半径

%平均所有圆上像素的位置得到圆心
centroid=[centH/count,centW/count];
%用面积计算半径
R=sqrt(count/pi);

%输出半径
%disp(R);

%——————————————————————————————————————
%标出高光点并计算各个高光点对应的光源向量

disp('开始计算高光点');
%遍历反光图像
for i=1:endIdx
    %读取并只取其中一通道来使用
    Img=imread([imageFolder,'/',int2str(i),'.bmp']);
    Img=Img(:,:,3);
    %运用遮罩
    Img=Img.*maskImg;
    
    %计算高光点
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
        
    %平均得到高光中心
    highlight=[centH/count,centW/count];
    
    %计算高光法线
    x=highlight(1)-centroid(1);
    y=highlight(2)-centroid(2);
    z=sqrt(R^2-x^2-y^2);
    %注意相机坐标系与平时用的直角坐标系是不同的
    normal=[y,-x,z];
    %单位化
    N=normal./R;
    
    %视点向量,由于指向高光点比较困难，看作直接朝前
    A=[0,0,1];
    %反射光源向量，可画图得
    lightVec(i,:)=2*(N*A')*N-A;
end
end
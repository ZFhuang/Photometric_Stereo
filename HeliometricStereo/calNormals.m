function [normals,rho]=calNormals(imageFolder,endIdx,lightVec)
%function [normals,rho]=calNormals(imageFolder,endIdx,lightVec)
%利用光源信息和图片组计算表面法线
%
%imageFolder:   重建图片文件所在的文件夹
%endIdx:        最后一个图片的名称索引号，文件名应是idx.bmp
%lightVec:      每张图片对应的光照方向向量
%
%example:   calNormals('Resources/Apollo',6,lightVec);

%——————————————————————————————————————
%读取遮罩

disp('————');
maskImg=imread([imageFolder,'/mask.png']);
height=size(maskImg,1);
width=size(maskImg,2);
%转为uint8
maskImg=uint8(maskImg&1);
disp('遮罩读取完毕');

%——————————————————————————————————————
%预处理图片，主要是应用遮罩并转为灰度图

disp('开始预处理');
%预分配空间
Images=zeros(size(maskImg,1),size(maskImg,2),endIdx);
%遍历目标图像
for i=1:endIdx
    %读取图像
    Img=imread([imageFolder,'/',int2str(i),'.bmp']);
    %遮罩
    Img=Img.*maskImg;
    %转灰度
    Images(:,:,i)=rgb2gray(Img);
end

%预分配空间
normals=zeros(height,width,3);

%——————————————————————————————————————
%构造计算方程求解法线

disp('开始计算');
%遍历每个像素
for h=1:height
    if rem(h,50)==0
        disp([num2str(h),'/',num2str(height)]);
    end
    for w=1:width
        %构造方程组
        I=double(reshape(Images(h,w,:),[1,endIdx]));
        if maskImg(h,w)~=0
            %最小二乘法的正规方程解
            X=pinv(lightVec'*lightVec)*(lightVec'*I');
        else
            X=[0,0,0]';
        end
        normals(h,w,:)=X;
    end
end

%——————————————————————————————————————
%后处理法线并计算反射率

%法线的模即为反射率rho
rho=sqrt(sum(normals.^2,3));
%单位化法线
normals=normals./rho;
rho=uint8(rho);

disp('————');
end
function [normals,rho]=calNormals(imageFolder,endIdx,lightPos)
disp('————');

%读取遮罩
maskImg=imread([imageFolder,'/mask.png']);
height=size(maskImg,1);
width=size(maskImg,2);
for h=1:height
    for w=1:width
        if maskImg(h,w)>200
            maskImg(h,w)=1;
        else
            maskImg(h,w)=0;
        end
    end
end
disp('遮罩读取完毕');

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
    
%     afterNorm=zeros(size(Img,1),size(Img,2));
%     
%     for h=1:size(Img,1)
%         for w=1:size(Img,2)
%             if maskImg(h,w)
%                 r=Img(:,:,1);
%                 g=Img(:,:,2);
%                 b=Img(:,:,3);
%                 N=norm(double([r,g,b]));
%                 afterNorm(h,w)=N;
%             end
%         end
%     end
%     
%     imshow(afterNorm,Map);
%     pause;
%     
%     Images(:,:,i+1)=afterNorm;
end

%预分配空间
normals=zeros(height,width,3);

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
            %最小二乘法
            X=pinv(lightPos'*lightPos)*lightPos'*I';
            
            %简易法
            %X=pinv(lightPos)*I';
        else
            X=[0,0,0]';
        end
        normals(h,w,:)=X;
    end
end

%法线的模即为反射率rho
rho=sqrt(sum(normals.^2,3));

%单位化法线
normals=normals./rho;

rho=uint8(rho);

disp('————');
end
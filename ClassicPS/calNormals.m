function [normals,rho]=calNormals(name,lightPos)
%读取遮罩
[maskImg,maskMap]=tga_read_image(['psmImages\',name,'\',name,'.mask.tga']);
%imshow(maskImg,maskMap);
%pause;
maskImg=uint8(maskImg&1);
Images=zeros(size(maskImg,1),size(maskImg,2),12);

%遍历反光图像
for i=0:11
    %读取图像
    [Img,Map]=tga_read_image(['psmImages\',name,'\',name,'.',mat2str(i),'.tga']);
    %遮罩
    Img=Img.*maskImg;
    %转灰度
    Images(:,:,i+1)=rgb2gray(Img);
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
height=size(Images,1);
width=size(Images,2);
normals=zeros(height,width,3);

%遍历每个像素
for h=1:height
    for w=1:width
        %构造方程组
        I=double(reshape(Images(h,w,:),[1,12]));
        if maskImg(h,w)~=0
            %最小二乘法
            X=pinv(lightPos'*lightPos)*lightPos'*I';
            
            %简易法
            %             X=pinv(lightPos)*I';
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

end
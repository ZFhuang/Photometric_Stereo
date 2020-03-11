function [normals,rho]=calNormals(imageFolder,endIdx,lightPos)
disp('��������');

%��ȡ����
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
disp('���ֶ�ȡ���');

disp('��ʼԤ����');
%Ԥ����ռ�
Images=zeros(size(maskImg,1),size(maskImg,2),endIdx);
%����Ŀ��ͼ��
for i=1:endIdx
    %��ȡͼ��
    Img=imread([imageFolder,'/',int2str(i),'.bmp']);
    %����
    Img=Img.*maskImg;
    %ת�Ҷ�
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

%Ԥ����ռ�
normals=zeros(height,width,3);

disp('��ʼ����');

%����ÿ������
for h=1:height
    if rem(h,50)==0
        disp([num2str(h),'/',num2str(height)]);
    end
    for w=1:width
        %���췽����
        I=double(reshape(Images(h,w,:),[1,endIdx]));
        if maskImg(h,w)~=0
            %��С���˷������淽�̽�
            X=pinv(lightPos'*lightPos)*lightPos'*I';
        else
            X=[0,0,0]';
        end
        normals(h,w,:)=X;
    end
end

%���ߵ�ģ��Ϊ������rho
rho=sqrt(sum(normals.^2,3));

%��λ������
normals=normals./rho;

rho=uint8(rho);

disp('��������');
end
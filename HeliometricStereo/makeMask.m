function makeMask(imageFolder,maskName)
%function makeMask(imageFolder,maskName)
%����������������ͼ��һ��������ͼ�е�ֵ����Ϊ[0,255]
%
%imageFolder:   ͼƬ�ļ���
%maskName:      ����ͼƬ��
%
%example:       makeMask('Resources/Apollo','mask.png');

%����������������������������������������������������������������������������
%��ȡ�ļ�
mask=imread([imageFolder,maskName]);
mask=rgb2gray(mask);
% imshow(mask);

height=size(mask,1);
width=size(mask,2);

%��������
for i=1:height
    for j=1:width
        if mask(i,j)~=0
            mask(i,j)=255;
        end
    end
end

%д���ļ�
imwrite(mask,['mask_',maskName]);
% figure;
% imshow(mask);
end
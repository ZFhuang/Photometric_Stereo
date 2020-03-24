function makeMask(imageFolder,maskName)
%function makeMask(imageFolder,maskName)
%将初步处理后的掩码图进一步处理，将图中的值更新为[0,255]
%
%imageFolder:   图片文件夹
%maskName:      掩码图片名
%
%example:       makeMask('Resources/Apollo','mask.png');

%——————————————————————————————————————
%读取文件
mask=imread([imageFolder,maskName]);
mask=rgb2gray(mask);
% imshow(mask);

height=size(mask,1);
width=size(mask,2);

%遍历处理
for i=1:height
    for j=1:width
        if mask(i,j)~=0
            mask(i,j)=255;
        end
    end
end

%写入文件
imwrite(mask,['mask_',maskName]);
% figure;
% imshow(mask);
end
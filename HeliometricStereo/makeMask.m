function makeMask(imageFolder,maskName)
%ÖÆ×÷ÑÚÂëÍ¼
mask=imread([imageFolder,maskName]);
mask=rgb2gray(mask);
% imshow(mask);

height=size(mask,1);
width=size(mask,2);

for i=1:height
    for j=1:width
        if mask(i,j)~=0
            mask(i,j)=255;
        end
    end
end

imwrite(mask,['mask_',maskName]);
figure;
imshow(mask);
end
function ret=toUintImg(img)
% ��������[-1,1]��ͼ

ret=uint8((img+1)*128);

% imshow(ret);
end
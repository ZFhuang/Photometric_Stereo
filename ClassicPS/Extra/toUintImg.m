function ret=toUintImg(img)
% 仅适用于[-1,1]的图

ret=uint8((img+1)*128);

% imshow(ret);
end
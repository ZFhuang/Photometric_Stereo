function newImg=getBumpMapping(path)
%function newImg=getBumpMapping(path)
%将图像的法线恢复到[-1,1]的double空间
%
%path:  待处理的图像路径
%
%example:   getBumpMapping('test.png');

%——————————————————————————————————————
%读取
normalImg=imread(path);
%转double
normalImg=im2double(normalImg);

%映射到[-1,1]
newImg=(normalImg-0.5).*2;
%单位化
newImg=toUnitVector(newImg);
% imshow(newImg);
end
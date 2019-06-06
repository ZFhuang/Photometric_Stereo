function newImg=getBumpMapping(path)
%将图像的法线恢复到[-1,1]的double空间

normalImg=imread(path);
normalImg=im2double(normalImg);

newImg=(normalImg-0.5).*2;

newImg=toUnitVector(newImg);

% imshow(newImg);

end
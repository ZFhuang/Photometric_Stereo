function newImg=getBumpMapping(path)
%��ͼ��ķ��߻ָ���[-1,1]��double�ռ�

normalImg=imread(path);
normalImg=im2double(normalImg);

newImg=(normalImg-0.5).*2;

newImg=toUnitVector(newImg);

% imshow(newImg);

end
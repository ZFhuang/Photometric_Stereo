function newImg=getDumpMapping(path)
%��ͼ��ķ��߻ָ���[-1,1]��double�ռ�

normalImg=imread(path);
normalImg=im2double(normalImg);

newImg=(normalImg-0.5).*2;

% imshow(newImg);

end
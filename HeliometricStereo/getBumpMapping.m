function newImg=getBumpMapping(path)
%function newImg=getBumpMapping(path)
%��ͼ��ķ��߻ָ���[-1,1]��double�ռ�
%
%path:  �������ͼ��·��
%
%example:   getBumpMapping('test.png');

%����������������������������������������������������������������������������
%��ȡ
normalImg=imread(path);
%תdouble
normalImg=im2double(normalImg);

%ӳ�䵽[-1,1]
newImg=(normalImg-0.5).*2;
%��λ��
newImg=toUnitVector(newImg);
% imshow(newImg);
end
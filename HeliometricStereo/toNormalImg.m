function ret=toNormalImg(normals)
%function ret=toNormalImg(normals)
%��[-1,1]�ķ���ͼתΪ[0,1]����ͨͼ
%
%normals:   ���߾���Ӧ��n*m*3��
%
%example:   toNormalImg(normalMap);

%����������������������������������������������������������������������������
%��תΪ��λ����
ret=toUnitVector(normals);
%�ٹ�һ��
ret=(ret(:,:,:)./2+0.5);

% imshow(ret);
end
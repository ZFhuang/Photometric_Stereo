function ret=toNormalImg(normals)
% ��[-1,1]�ķ���ͼתΪ[0,1]����ͨͼ

ret=toUnitVector(normals);

ret=(ret(:,:,:)./2+0.5);

% imshow(ret);
end
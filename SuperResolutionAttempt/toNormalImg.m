function ret=toNormalImg(normals)
% 将[-1,1]的法线图转为[0,1]的普通图

ret=toUnitVector(normals);

ret=(ret(:,:,:)./2+0.5);

% imshow(ret);
end
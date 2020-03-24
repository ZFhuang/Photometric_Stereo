function ret=toNormalImg(normals)
%function ret=toNormalImg(normals)
%将[-1,1]的法线图转为[0,1]的普通图
%
%normals:   法线矩阵，应是n*m*3的
%
%example:   toNormalImg(normalMap);

%——————————————————————————————————————
%先转为单位向量
ret=toUnitVector(normals);
%再归一化
ret=(ret(:,:,:)./2+0.5);

% imshow(ret);
end
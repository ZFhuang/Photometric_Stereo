%得到单位向量组成的法线
path='horse_norm3.png';
normals=getBumpMapping(path);
normals=toNormalImg(normals);
% imshow(ret);
path=['Unit_',path];
imwrite(normals,path);
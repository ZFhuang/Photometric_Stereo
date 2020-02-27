function ret=toUnitVector(inp)
% 返回重整的单位向量矩阵

ret=inp;
scales=sqrt(ret(:,:,1).^2+ret(:,:,2).^2+ret(:,:,3).^2);
ret(:,:,1)=ret(:,:,1)./scales;
ret(:,:,2)=ret(:,:,2)./scales;
ret(:,:,3)=ret(:,:,3)./scales;
end
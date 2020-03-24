function ret=toUnitVector(inp)
%function ret=toUnitVector(inp)
%返回重整的单位向量矩阵
%优点是可以一次性处理一整个矩阵
%
%inp:   需要重整的向量矩阵
%
%example:   toUnitVector(vector);

%——————————————————————————————————————
ret=inp;
%得到模长
scales=sqrt(ret(:,:,1).^2+ret(:,:,2).^2+ret(:,:,3).^2);
%相除
ret(:,:,1)=ret(:,:,1)./scales;
ret(:,:,2)=ret(:,:,2)./scales;
ret(:,:,3)=ret(:,:,3)./scales;
end
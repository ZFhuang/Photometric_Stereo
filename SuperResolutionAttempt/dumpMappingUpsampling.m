function ret=dumpMappingUpsampling(path,rate)
%恢复oriPath的法线图
%参数rate指每个像素要扩张成多大(rate*rate)
%直接将法线复制给对应的像素区

normals=getDumpMapping(path);
x=size(normals,1);
y=size(normals,2);
resultMap=zeros(x*rate,y*rate,3);

for i=1:x
    for j=1:y
        for k=1:rate
            for l=1:rate
                resultMap((i-1)*rate+k,(j-1)*rate+l,1)=normals(i,j,1);
                resultMap((i-1)*rate+k,(j-1)*rate+l,2)=normals(i,j,2);
                resultMap((i-1)*rate+k,(j-1)*rate+l,3)=normals(i,j,3);
            end
        end
    end
end

ret=toNormalImg(resultMap);
% imshow(ret);
path=[num2str(rate),'x',num2str(rate),'up_',path];
imwrite(ret,path);

end
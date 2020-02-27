function ret=dumpMappingEnhance01(path,rate)
%试着进行插值

normals=getDumpMapping(path);
x=size(normals,1);
y=size(normals,2);
resultMap=zeros(size(normals));
pad=rate/2

for i=1:x
    for j=1:y
        count=0;
        for k=1:rate
            for l=1:rate
                if i-k<
            end
        end
    end
end

ret=toNormalImg(resultMap);
% imshow(ret);
path=[num2str(rate),'x',num2str(rate),'up_',path];
imwrite(ret,path);

end
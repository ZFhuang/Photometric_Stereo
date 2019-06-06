function ret=bumpMappingDownsampling(path,rate)
%下采样oriPath的法线图
%参数rate指要按照多大的区域取平均(rate*rate)

normals=getBumpMapping(path);
x=size(normals,1);
y=size(normals,2);
resultMap=zeros(floor(x/rate),floor(y/rate),3);

for i=1:floor(x/rate)
    for j=1:floor(y/rate)
        avgBlock=zeros(3,1);
        count=0;
        for k=1:rate
            for l=1:rate
                if (i-1)*rate+k<=x&&(j-1)*rate+l<=y
                    count=count+1;
                    avgBlock(1)=avgBlock(1)+double(normals((i-1)*rate+k,(j-1)*rate+l,1));
                    avgBlock(2)=avgBlock(2)+double(normals((i-1)*rate+k,(j-1)*rate+l,2));
                    avgBlock(3)=avgBlock(3)+double(normals((i-1)*rate+k,(j-1)*rate+l,3));
                end
            end
        end
        avgBlock=avgBlock./count;
        resultMap(i,j,1)=avgBlock(1);
        resultMap(i,j,2)=avgBlock(2);
        resultMap(i,j,3)=avgBlock(3);
    end
end

ret=toNormalImg(resultMap);
% imshow(ret);
path=[num2str(rate),'x',num2str(rate),'down_',path];
imwrite(ret,path);

end
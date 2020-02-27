function ret=bumpMappingEnhance01(path,~)
%rate先默认是3吧
%粗糙比
SCALE=0.33;
%动态粗糙比阈值
deltaT=0.3;
rate=3;
normals=getBumpMapping(path);
x=size(normals,1);
y=size(normals,2);
resultMap=zeros(x*rate,y*rate,3);

for i=1:x
    for j=1:y
        %rate先默认是3吧
        for k=1:rate
            for l=1:rate
                if i+(k-2)>0&&i+(k-2)<x+1 && j+(l-2)>0&&j+(l-2)<y+1
                    for n=1:3
                        delta=normals(i,j,n)-normals(i+(k-2),j+(l-2),n);
                        scale=SCALE;
                        if abs(delta)>deltaT
                            scale=0.3;
                        end
                        resultMap((i-1)*rate+k,(j-1)*rate+l,n)=normals(i,j,n)-scale*delta;
                    end
                end
            end
        end
    end
end

ret=toNormalImg(resultMap);
% imshow(ret);
path=[num2str(rate),'x',num2str(rate),'upE1_',path];
imwrite(ret,path);

end
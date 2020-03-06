normals=zeros(100,100,3);
R=45;

for i=1:100
    for j=1:100
        %计算对应点法线
        x=i-50;
        y=j-50;
        
        %在球外
        if R^2-x^2-y^2<0
            continue;
        end
        
        z=sqrt(R^2-x^2-y^2);
        normal=[y,-x,z];
        %单位化
        N=normal./R;
        %存入
        normals(i,j,:)=N;
    end
end

% normals=normals+1;
% normals=normals/2;
% imshow(normals(:,:,:));

show_surfNorm(normals, 3);
function writeObj3(Vxyz,norm_s,constraints2Vertices,ln,name)

m1=size(Vxyz,1);
k1=size(Vxyz,2);
m2=size(constraints2Vertices,1);
k2=size(constraints2Vertices,2);

fn=strcat(ln,'\',name,'.txt');
fid=fopen(fn,'w');

if isempty(norm_s)
    for i=1:m1
        writeline(fid,'v',Vxyz(i,:),k1,'%f');
    end
else
    for i=1:m1
        writeline(fid,'v',Vxyz(i,:),k1,'%f');        
    end
    for i=1:m1
        writeline(fid,'vn',norm_s(i,:),k1,'%f');    
    end
end

for i=1:m2
    writeline(fid,'f',constraints2Vertices(i,:),k2,'%d');
end

fclose(fid);
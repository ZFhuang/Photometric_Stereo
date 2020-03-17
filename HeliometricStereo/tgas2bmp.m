function tgas2bmp(path,name,hasIdx,Start,End)
%函数: tgas2png(path,name,hasIdx,Start,End);
%
%需要tga_read_image.m和tga_read_header.m的支持
%用途是将ps样例代码中的测试样例tga格式图片转存为bmp
%
%path: 文件路径
%name: 文件前缀名
%hasIdx: bool型，当存在时后两个参数才会被应用，会处理带有此序号的图片
%Start: 第一个序号
%End: 最后一个序号
%待处理的文件名格式: [路径, '/', 文件前缀名, 序号, '.tga']
%处理后的文件名格式: [路径, '/', 序号或独文件名, '.bmp']
%处理后的序号从1开始
%
%范例1: tgas2png('Light', 'lights', true, 0, 10);
%范例2: tgas2png('Light', 'mask', false, -1, -1);

if hasIdx==true
    for i=Start:End
        fname=[path,'/',name,num2str(i),'.tga'];
        info=tga_read_header(fname);
        [I,Map] = tga_read_image(info);
        
        if size(Map,1)~=0
            imwrite(I,Map,[path,'/',num2str(i-Start+1),'.bmp']);
        else
            imwrite(I,[path,'/',num2str(i-Start+1),'.bmp']);
        end
    end
else
    fname=[path,'/',name,'.tga'];
    info=tga_read_header(fname);
    [I,Map] = tga_read_image(info);

    if size(Map,1)~=0
        imwrite(I,Map,[path,'/',name,'.bmp']);
    else
        imwrite(I,[path,'/',name,'.bmp']);
    end
end

end
function tgas2bmp(path,name,hasIdx,Start,End)
%function tgas2bmp(path,name,hasIdx,Start,End);
%需要tga_read_image.m和tga_read_header.m的支持
%用途是将ps样例代码中的测试样例tga格式图片转存为bmp
%本质就只是读取并原样转存到bmp格式
%
%path:      文件路径
%name:      文件前缀名
%hasIdx:    bool型，当存在时后两个参数才会被应用，会处理带有此序号的图片
%Start:     第一个序号
%End:       最后一个序号
%
%待处理的文件名格式:     [路径, '/', 文件前缀名, 序号, '.tga']
%处理后的文件名格式:     [路径, '/', 序号或独文件名, '.bmp']
%处理后的序号从1开始
%example:   tgas2bmp('Light', 'lights', true, 0, 10);
%example:   tgas2bmp('Light', 'mask', false, -1, -1);

%——————————————————————————————————————
%当是要处理一批数据时
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
%当只要处理一个数据时
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
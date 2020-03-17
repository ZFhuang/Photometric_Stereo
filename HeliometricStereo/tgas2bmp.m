function tgas2bmp(path,name,hasIdx,Start,End)
%����: tgas2png(path,name,hasIdx,Start,End);
%
%��Ҫtga_read_image.m��tga_read_header.m��֧��
%��;�ǽ�ps���������еĲ�������tga��ʽͼƬת��Ϊbmp
%
%path: �ļ�·��
%name: �ļ�ǰ׺��
%hasIdx: bool�ͣ�������ʱ�����������ŻᱻӦ�ã��ᴦ�����д���ŵ�ͼƬ
%Start: ��һ�����
%End: ���һ�����
%���������ļ�����ʽ: [·��, '/', �ļ�ǰ׺��, ���, '.tga']
%��������ļ�����ʽ: [·��, '/', ��Ż���ļ���, '.bmp']
%���������Ŵ�1��ʼ
%
%����1: tgas2png('Light', 'lights', true, 0, 10);
%����2: tgas2png('Light', 'mask', false, -1, -1);

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
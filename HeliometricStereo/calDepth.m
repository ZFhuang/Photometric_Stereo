function depths=calDepth(normals,imageFolder)
%function depths=calDepth(normals,imageFolder)
%�ӷ���ͼ�������ͼ
%
%normals:       ����ķ��߾���
%imageFolder:   �����ļ����ڵ��ļ��У������ļ���Ϊmask.png
%
%example:   calDepth(normals,'Resources/Apollo');

%����������������������������������������������������������������������������
%��ȡ����

disp('��������');
height=size(normals,1);
width=size(normals,2);
depths=zeros(height,width);
mask=imread([imageFolder,'/mask.png']);
mask=mask(:,:,1);
height=size(mask,1);
width=size(mask,2);

%��Ϊ[0,1]
for h=1:height
    for w=1:width
        if mask(h,w)>200
            mask(h,w)=1;
        else
            mask(h,w)=0;
        end
    end
end
disp('���ֶ�ȡ���');

%����������������������������������������������������������������������������
%�Լ��������г�ʼ��
%�ο���https://github.com/xiumingzhang/photometric-stereo

%��ʼ������
[maskH, maskW] = find(mask);    %�ҵ����������ڵĵ������
pixels = size(maskH, 1);    %��������
oriIdx = zeros(height, width);
for idx = 1:size(maskH, 1)
    %��ʼ��һ�����󱣴�ͼ�������ڵĵ������
    oriIdx(maskH(idx), maskW(idx)) = idx;
end

%����ϡ�����M�ǳ������������ߣ�u���ұߣ�����M�кܶ���ʹ��ϡ������ʡ�ռ�
M = sparse(2*pixels, pixels);
u = sparse(2*pixels, 1);

%����������������������������������������������������������������������������
%�����ʼ������

disp('����ϡ�跽�̾���');
empty_row = [];   %��¼���õ���,���Ȳ���
%����ÿһ����Χ������
for idx = 1:pixels
    if rem(idx,1000)==0
        disp([num2str(idx),'/',num2str(pixels)]);
    end
    
    %��ȡ��Ӧ��ͼ������
    h = maskH(idx);
    w = maskW(idx);
    %����������ȡ������
    nx = normals(h, w, 1);
    ny = normals(h, w, 2);
    nz = normals(h, w, 3);
    
    %�ӷ�����ĵ�һ�У���ֱ�ھӣ�row_idx�����ڷ���������е���λ��
    row_idx = (idx-1)*2+1;
    if h+1<=height&&mask(h+1, w) %���ھӴ���ʱ
        %����M�����鳤���Ƕ�Ӧ���е�ģ����������ھӵ����
        idx_vertN = oriIdx(h+1, w);
        %���չ�ʽ����ϵ�����������
        u(row_idx) = ny;
        M(row_idx, idx) = -nz;
        M(row_idx, idx_vertN) = nz;
    elseif h-1>=1&&mask(h-1, w)
        %�˲��������ھ�
        idx_vertN = oriIdx(h-1, w);
        u(row_idx) = -ny;
        M(row_idx, idx) = -nz;
        M(row_idx, idx_vertN) = nz;
    else
        %�Ҳ����ھ�ʱ�ڿհ��б������˵�
        empty_row = [empty_row; row_idx];
    end
    %���Ƶ����������ھ�
    row_idx = (idx-1)*2+2;
    if w+1<=width&&mask(h, w+1)
        %��
        idx_horizN = oriIdx(h, w+1);
        u(row_idx) = -nx;
        M(row_idx, idx) = -nz;
        M(row_idx, idx_horizN) = nz;
    elseif w-1>=1&&mask(h, w-1)
        %��
        idx_horizN = oriIdx(h, w-1);
        u(row_idx) = nx;
        M(row_idx, idx) = -nz;
        M(row_idx, idx_horizN) = nz;
    else
        empty_row = [empty_row; row_idx];
    end
end

%���ݸղŵĿհ��б�ɾȥ������
M(empty_row, :) = [];
u(empty_row, :) = [];

%����������������������������������������������������������������������������
%����С���˷��ⷽ��

disp('��ʼ�ⷽ��');
z = (M.'*M)\(M.'*u);
%z=pinv(M)*u;   %svd��֧��ϡ�����

%�ָ�Ϊ��ͨ����
z = full(z);

%�����쳣ֵ
outlier_ind = abs(zscore(z))>10;
z_min = min(z(~outlier_ind));
z_max = max(z(~outlier_ind));

for idx = 1:pixels
    %�������Ϣ��һά��ԭΪ��ά
    h = maskH(idx);
    w = maskW(idx);
    %�ڶ�ά�ľ���Ķ�Ӧλ������
    depths(h, w) = (z(idx)-z_min)/(z_max-z_min)*255;
end

%ɾȥ���õ�
depths(depths==0)=nan;
%depths=depths-min(depths(~isnan(depths)));
end
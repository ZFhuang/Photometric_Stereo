function depths=calDepth(normals,imageFolder)
height=size(normals,1);
width=size(normals,2);
depths=zeros(height,width);

%读取遮罩
mask=imread([imageFolder,'/mask.png']);
height=size(mask,1);
width=size(mask,2);
for h=1:height
    for w=1:width
        if mask(h,w)>200
            mask(h,w)=1;
        else
            mask(h,w)=0;
        end
    end
end
disp('遮罩读取完毕');

% %遍历每个像素最小二乘法
% for h=2:height
%     for w=2:width
%         if  ~isnan(normals(h-1,w,2)) && ~isnan(normals(h-1,w,3))&&...
%                 ~isnan(normals(h,w-1,1)) && ~isnan(normals(h,w-1,3))
%             A=[1,1]';
%             b=[depths(h-1,w)+normals(h-1,w,2)/normals(h-1,w,3),...
%                 depths(h,w-1)-normals(h,w-1,1)/normals(h,w-1,3)]';
%             %区别？
%             %             n=A.'*A;
%             %             m=A.'*b;
%             %             x=n\m;
%             x=pinv(A'*A)*A'*b;
%             %             x=pinv(A)*b;
%             depths(h,w)=x;
%         elseif ~isnan(normals(h-1,w,2)) && ~isnan(normals(h-1,w,3))
%             depths(h,w)=depths(h-1,w)-normals(h-1,w,2)/normals(h-1,w,3);
%         elseif ~isnan(normals(h,w-1,1)) && ~isnan(normals(h,w-1,3))
%             depths(h,w)=depths(h,w-1)+normals(h,w-1,1)/normals(h,w-1,3);
%         end
%     end
% end

%最小二乘法,参考https://github.com/xiumingzhang/photometric-stereo

%初始化矩阵
[maskH, maskW] = find(mask);    %找到所有遮罩内的点的坐标
pixels = size(maskH, 1);    %计算数量
oriIdx = zeros(height, width);
for idx = 1:size(maskH, 1)
    %初始化一个矩阵保存图像遮罩内的点的排序
    oriIdx(maskH(idx), maskW(idx)) = idx;
end

%创建稀疏矩阵，M是超定方程组的左边，u是右边，由于M有很多项使用稀疏矩阵节省空间
M = sparse(2*pixels, pixels);
u = sparse(2*pixels, 1);

disp('开始计算');
empty_row = [];   %记录无用的行,长度不定
%遍历每一个范围内像素
for idx = 1:pixels
    if rem(idx,1000)==0
        disp([num2str(idx),'/',num2str(pixels)]);
    end
    
    %获取对应的图像坐标
    h = maskH(idx);
    w = maskW(idx);
    %利用坐标提取出法线
    nx = normals(h, w, 1);
    ny = normals(h, w, 2);
    nz = normals(h, w, 3);
    
    %子方程组的第一行，垂直邻居，row_idx是其在方程组矩阵中的行位置
    row_idx = (idx-1)*2+1;
    if h+1<=height&&mask(h+1, w) %上邻居存在时
        %由于M方程组长度是对应所有点的，计算其上邻居的序号
        idx_vertN = oriIdx(h+1, w);
        %按照公式将其系数填入矩阵中
        u(row_idx) = ny;
        M(row_idx, idx) = -nz;
        M(row_idx, idx_vertN) = nz;
    elseif h-1>=1&&mask(h-1, w)
        %此部分是下邻居
        idx_vertN = oriIdx(h-1, w);
        u(row_idx) = -ny;
        M(row_idx, idx) = -nz;
        M(row_idx, idx_vertN) = nz;
    else
        %找不到邻居时在空白列表里加入此点
        empty_row = [empty_row; row_idx];
    end
    %类似的这是左右邻居
    row_idx = (idx-1)*2+2;
    if w+1<=width&&mask(h, w+1)
        %右
        idx_horizN = oriIdx(h, w+1);
        u(row_idx) = -nx;
        M(row_idx, idx) = -nz;
        M(row_idx, idx_horizN) = nz;
    elseif w-1>=1&&mask(h, w-1)
        %左
        idx_horizN = oriIdx(h, w-1);
        u(row_idx) = nx;
        M(row_idx, idx) = -nz;
        M(row_idx, idx_horizN) = nz;
    else
        empty_row = [empty_row; row_idx];
    end
end

%依据刚才的空白列表删去多余行
M(empty_row, :) = [];
u(empty_row, :) = [];

disp('开始解方程');
%解方程，得到Z的稀疏矩阵
z = (M.'*M)\(M.'*u);
%z=pinv(M)*u;   %svd不支持稀疏矩阵

%恢复为普通矩阵
z = full(z);

for idx = 1:pixels
    %将深度信息从一维还原为二维
    h = maskH(idx);
    w = maskW(idx);
    %在二维的矩阵的对应位置填入
    depths(h, w) = z(idx);
end

%递归扩散测试
% [h, w] = find(~isnan(normals(:,:,1)));
% depths=recursionDepth(normals,depths,h(1),w(1));

%删去无用点
depths(depths==0)=nan;
%depths=depths-min(depths(~isnan(depths)));
end

%递归扩散，效果不好
function depths=recursionDepth(normals,depths,h,w)

if h~=size(depths,1)&&depths(h+1,w)==0
    if ~isnan(normals(h,w,1)) && ~isnan(normals(h,w,2)) && ~isnan(normals(h,w,3))
        depths(h+1,w)=depths(h,w)+normals(h,w,2)/normals(h,w,3);
        depths=recursionDepth(normals,depths,h+1,w);
    end
end
if h~=1&&depths(h-1,w)==0
    if ~isnan(normals(h-1,w,1)) && ~isnan(normals(h-1,w,2)) && ~isnan(normals(h-1,w,3))
        depths(h-1,w)=depths(h,w)-normals(h-1,w,2)/normals(h-1,w,3);
        depths=recursionDepth(normals,depths,h-1,w);
    end
end

if w~=size(depths,2)&&depths(h,w+1)==0
    if ~isnan(normals(h,w,1)) && ~isnan(normals(h,w,2)) && ~isnan(normals(h,w,3))
        depths(h,w+1)=depths(h,w)-normals(h,w,1)/normals(h,w,3);
        depths=recursionDepth(normals,depths,h,w+1);
    end
end
if w~=1&&depths(h,w-1)==0
    if ~isnan(normals(h,w-1,1)) && ~isnan(normals(h,w-1,2)) && ~isnan(normals(h,w-1,3))
        depths(h,w-1)=depths(h,w)+normals(h,w-1,1)/normals(h,w-1,3);
        depths=recursionDepth(normals,depths,h,w-1);
    end
end

end
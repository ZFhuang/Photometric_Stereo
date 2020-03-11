lightsFolder='Resources/Lights';
objectFolder='Resources/Apollo';
endIdx=16;

disp('开始光源处理');
%计算光源
lightPos=calLight(lightsFolder,endIdx);
%保存光源
save([lightsFolder,'/lightPos.txt'],'lightPos','-ascii');
%读取光源
lightPos = load([lightsFolder,'/lightPos.txt'],'-ascii');
disp('光源处理完毕');

%计算法线和反射率rho
disp('开始计算法线和反射率');
[normals,rho]=calNormals(objectFolder,endIdx,lightPos);
disp('计算法线和反射率完毕');

%显示法线图
show_surfNorm(normals, 4);
pause;

%RGB显示法线图
imshow(toNormalImg(normals));
pause;

%显示反射率图
imshow(rho);
pause;

%计算深度图
depths = calDepth(normals, objectFolder);

%显示深度图
disp('显示深度');
minD = min(depths(~isnan(depths)));
maxD = max(depths(~isnan(depths)));
depths2D=(depths-minD)/(maxD-minD)*255;
imshow(uint8(depths2D));
pause;
surfl(depths);
pause;

% %制作掩码图
% mask=imread([imageFolder,'ApolloMask.png']);
% mask=rgb2gray(mask);
% % imshow(mask);
% 
% height=size(mask,1);
% width=size(mask,2);
% 
% for i=1:height
%     for j=1:width
%         if mask(i,j)~=0
%             mask(i,j)=255;
%         end
%     end
% end
% 
% imwrite(mask,'ApolloMask2.png');
% imshow(mask);

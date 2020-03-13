% lightsFolder='Resources/Lights';
% objectFolder='Resources/Apollo';
% endIdx=4;
% 
% disp('开始光源处理');
% %计算光源
% lightPos=calLight(lightsFolder,endIdx);
% %保存光源
% save([lightsFolder,'/lightPos.txt'],'lightPos','-ascii');
% %读取光源
% lightPos = load([lightsFolder,'/lightPos.txt'],'-ascii');
% disp('光源处理完毕');
% 
% %计算法线和反射率rho
% disp('开始计算法线和反射率');
% [normals,rho]=calNormals(objectFolder,endIdx,lightPos);
% disp('计算法线和反射率完毕');
% 
% %显示法线图
% figure;
% show_surfNorm(normals, 4);
% 
% %RGB显示法线图
% figure;
% imshow(toNormalImg(normals));
% 
% %显示反射率图
% figure;
% imshow(rho);
% 
% %计算深度图
% depths = calDepth(normals, objectFolder);

%显示深度图
disp('显示深度');
minD = min(depths(~isnan(depths)));
maxD = max(depths(~isnan(depths)));
depths2D=(depths-minD)/(maxD-minD)*255;
figure;
imshow(uint8(depths2D));
% pause;
figure;
s=surfl(depths);
s.EdgeColor = 'none';
% pause;

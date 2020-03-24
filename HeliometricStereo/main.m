% %主脚本，包含了一轮重建的所有步骤
% 
% %——————————————————————————————————————
% %基础文件夹指定和文件遍历数量指定
% 
% lightsFolder='Resources/Lights';
% objectFolder='Resources/Apollo';
% endIdx=6;
% 
% %——————————————————————————————————————
% %计算光源信息
% 
% disp('开始光源处理');
% % %用标定球计算光源
% % lightPos=calLight(lightsFolder,endIdx);
% %用地理信息计算光源
% lightVec=calLightSun(lightsFolder,endIdx);
% %保存光源
% save([lightsFolder,'/lightPos.txt'],'lightVec','-ascii');
% %读取光源
% lightVec = load([lightsFolder,'/lightPos.txt'],'-ascii');
% disp('光源处理完毕');
% 
% %——————————————————————————————————————
% %还原表面法线并显示
% 
% %计算法线和反射率rho
% disp('开始计算法线和反射率');
% [normals,rho]=calNormals(objectFolder,endIdx,lightVec);
% disp('计算法线和反射率完毕');
% 
% %显示法线图
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
% %——————————————————————————————————————
% %从法线还原表面深度信息
% 
% %计算深度图
% disp('开始计算深度');
% depths = calDepth(normals, objectFolder);
% disp('开始深度计算完毕');
% 
% %显示深度图
% disp('————');
% disp('显示深度');
% minD = min(depths(~isnan(depths)));
% maxD = max(depths(~isnan(depths)));
% depths2D=(depths-minD)/(maxD-minD)*255;
% figure;
% imshow(uint8(depths2D));
% % pause;
% figure;
%绘制时需要对深度信息进行转置才能正常显示
s=surfl(depths');
s.EdgeColor = 'none';

%导出为stl文件
surf2stl('Outputs/outputSTL.stl',s.XData,s.YData,s.ZData);

% pause;

% %下采样
% dumpMappingDownsampling('Rock.jpg',2);
% %恢复
% dumpMappingUpsampling('2x2down_Rock.jpg',2);
% %比较
% compare('Rock.jpg','2x2up_2x2down_Rock.jpg');
%锐化
sharpen('2x2up_2x2down_Rock.jpg');
%比较
compare('Rock.jpg','LapShapZ_2x2up_2x2down_Rock.jpg');

% %下采样
% dumpMappingDownsampling('Coin.png',3);
% %恢复
% dumpMappingUpsampling('3x3down_Coin.png',3);
% %比较
% compare('Coin.png','3x3up_3x3down_Coin.png');
% 
% pause;
% 
% %锐化
% sharpen('3x3up_3x3down_Coin.png');
% %比较
% compare('Coin.png','CanShapZ_3x3up_3x3down_Coin.png');

% %下采样
% dumpMappingDownsampling('horse_norm3.png',2);
% %恢复
% dumpMappingUpsampling('2x2down_horse_norm3.png',2);
% %比较
% compare('horse_norm3.png','2x2up_2x2down_horse_norm3.png');

% %下采样
% dumpMappingDownsampling('Coin.png',2);
% %恢复
% dumpMappingUpsampling('2x2down_Coin.png',2);
% %比较
% compare('Coin.png','2x2up_2x2down_Coin.png');

% ori=getDumpMapping('Coin.png');
% oriX=ori(180:200,180:200,1);
% oriY=ori(180:200,180:200,2);
% oriZ=ori(180:200,180:200,3);
% after=getDumpMapping('3x3up_3x3down_Coin.png');
% afterX=after(180:200,180:200,1);
% afterY=after(180:200,180:200,2);
% afterZ=after(180:200,180:200,3);
% pause;

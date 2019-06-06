% %下采样
% bumpMappingDownsampling('Rock.jpg',2);
% %恢复
% bumpMappingUpsampling('2x2down_Rock.jpg',2);
% %比较
% compare('Rock.jpg','2x2up_2x2down_Rock.jpg');
% %锐化
% sharpen('2x2up_2x2down_Rock.jpg');
% %比较
% compare('Rock.jpg','LapShapZ_2x2up_2x2down_Rock.jpg');

% %下采样
% bumpMappingDownsampling('Unit_Coin.png',3);
% %恢复
% bumpMappingUpsampling('3x3down_Unit_Coin.png',3);
% %恢复
% bumpMappingEnhance01('3x3down_Unit_Coin.png',3);
% %比较
% compare('Unit_Coin.png','3x3upE1_3x3down_Coin.png');
% 
% pause;
% 
% %锐化
% sharpen('3x3up_3x3down_Coin.png');
% %比较
% compare('Coin.png','CanShapZ_3x3up_3x3down_Coin.png');

% %下采样
% bumpMappingDownsampling('horse_norm3.png',2);
% %恢复
% bumpMappingUpsampling('2x2down_horse_norm3.png',2);
% %比较
% compare('horse_norm3.png','2x2up_2x2down_horse_norm3.png');

% %下采样
% bumpMappingDownsampling('Coin.png',2);
% %恢复
% bumpMappingUpsampling('2x2down_Coin.png',2);
% %比较
% compare('Coin.png','2x2up_2x2down_Coin.png');

% pause;

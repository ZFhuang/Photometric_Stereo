% %�²���
% dumpMappingDownsampling('Rock.jpg',2);
% %�ָ�
% dumpMappingUpsampling('2x2down_Rock.jpg',2);
% %�Ƚ�
% compare('Rock.jpg','2x2up_2x2down_Rock.jpg');
%��
sharpen('2x2up_2x2down_Rock.jpg');
%�Ƚ�
compare('Rock.jpg','LapShapZ_2x2up_2x2down_Rock.jpg');

% %�²���
% dumpMappingDownsampling('Coin.png',3);
% %�ָ�
% dumpMappingUpsampling('3x3down_Coin.png',3);
% %�Ƚ�
% compare('Coin.png','3x3up_3x3down_Coin.png');
% 
% pause;
% 
% %��
% sharpen('3x3up_3x3down_Coin.png');
% %�Ƚ�
% compare('Coin.png','CanShapZ_3x3up_3x3down_Coin.png');

% %�²���
% dumpMappingDownsampling('horse_norm3.png',2);
% %�ָ�
% dumpMappingUpsampling('2x2down_horse_norm3.png',2);
% %�Ƚ�
% compare('horse_norm3.png','2x2up_2x2down_horse_norm3.png');

% %�²���
% dumpMappingDownsampling('Coin.png',2);
% %�ָ�
% dumpMappingUpsampling('2x2down_Coin.png',2);
% %�Ƚ�
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

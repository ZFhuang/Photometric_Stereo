function errorMap=errorAnalyse(pathA,pathB)
%��������ͼ֮��Ķ�Ӧλ�÷��߽ǶȲ���
%Ϊ�˷�ֹ��Ե���⣬�������Ե6��������
normalsA=getBumpMapping(pathA);
normalsB=getBumpMapping(pathB);

x=size(normalsA,1);
y=size(normalsA,2);
errorMap=zeros(x,y);

for i=6:x-6
    for j=6:y-6
        errorMap(i,j)=vectorAngle(normalsA(i,j,:),normalsB(i,j,:));
    end
end

disp('angle');
disp(sum(errorMap(:)));
% 
% imshow(errorMap);
% path=['ErrorMap_',pathA,'_',pathB,'.png'];
% imwrite(errorMap,path);
disp('mse');
err=immse(normalsA,normalsB);
disp(err);
disp('ssim');
ssimval = ssim(normalsA,normalsB);
disp(ssimval);
end
function ret=toUnitVector(inp)
% ���������ĵ�λ��������

ret=inp;
scales=sqrt(ret(:,:,1).^2+ret(:,:,2).^2+ret(:,:,3).^2);
ret(:,:,1)=ret(:,:,1)./scales;
ret(:,:,2)=ret(:,:,2)./scales;
ret(:,:,3)=ret(:,:,3)./scales;
end
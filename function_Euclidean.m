function dst=cvpr_Euclidean(F1,F2)

% Euclidean Distance between Descriptors
x=F1-F2;
x=x.^2;
x=sum(x);
dst=sqrt(x);

return;

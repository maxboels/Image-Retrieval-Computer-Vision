function dst=function_Manhattan(query,candidate)

% Euclidean Distance between Descriptors
x=query-candidate;
x=abs(x);
dst=sum(x);

return;
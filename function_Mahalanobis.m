function mdist=function_Mahalanobis(query, candidate, all_features)

all_featuresT = all_features.';
eigen= Eigen_Build(all_featuresT);
V=eigen.val;

x = query - candidate;
x = x.^2./V(1:size(candidate,2), 1)';
x = sum(x);
mdist = sqrt(x);

return;

% %subtract the mean of the Eigen model from the candidate
% queryT = query.';
% eigen= Eigen_Build(queryT);
% xsub = candidate - eigen.org;
% %Compute the distance from the Model in units of variance.
% V = diag(eigen.val); %Eigenvalues or variance explained from each principal component
% U =  eigen.vct; % vectors describing the spread of the distribution along dimensions
% mdist_squared = xsub' * U * inv(V) * U' * xsub;
% mdist = sqrt(mdist_squared);

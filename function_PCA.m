function N_principal_components=function_PCA(all_features) % F is the grid descriptor

all_featuresT = all_features.';
eigen= Eigen_Build(all_featuresT);
%eigen_val_dim=eigen.val; 
eigen_n = Eigen_Deflate(eigen, 'keepf', 0.97); 
N_principal_components = Eigen_Project(all_featuresT, eigen_n)';

totalenergy=sum(abs(eigen.val));
rank = 1;
for i=1:size(eigen.vct,2)
    currentvariance(i, 1)=sum(eigen.val(1:rank,1))/totalenergy;
    rank = rank + 1;
end
%% Uncomment for Elbow Graph
% plot(1:108, currentvariance)
% xlabel('Number of Eigenvectors')
% ylabel('Variance %')
% title("Explained Variance by Eigenvectors")
% legend('varaince', 'treshold', 'optimal number of dimensions')
% yline(0.97, 'r--')
% xline(35, 'm--')
% legend('varaince', 'treshold', 'optimal number of dimensions')
return;


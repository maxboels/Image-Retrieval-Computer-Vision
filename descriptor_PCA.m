% Descriptor
close all;
clear all;
%choose the number of dimensions
n_rows = 6;
m_columns = 6;
RGB = 3;
all_features = zeros(591, n_rows*m_columns*RGB);
% Folders
DATASET_FOLDER = 'C:/Users/Administrator/Documents/SURREY CVRML/CV&PR/Lab/MSRC_ObjCategImageDatabase_v2';
OUT_FOLDER = 'C:/Users/Administrator/Documents/SURREY CVRML/CV&PR/Lab/descriptors';
OUT_SUBFOLDER='PCA_descriptor';

allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic; %time
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./256; %read and normalize
    F=function_Grid_descriptor(img, n_rows, m_columns); %descriptor
    all_features(filenum, :) = F; 
    toc %time
end
FF=function_PCA(all_features); %grid descriptor into a lower dim space.
for fileid = 1:591
    fname=allfiles(fileid).name;
    fprintf('Processing file %d/%d - %s\n',fileid,length(allfiles),fname);
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./256; %read and normalize
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    F=FF(fileid, :);
    save(fout,'F'); %fout is the directory
end
% figure()
% hold on
% plot3(FF(1:30,1), FF(1:30,2), FF(1:30,3),'gx');
% hold on
% plot3(FF(31:60,1), FF(31:60,2), FF(31:60,3),'kx');
% hold on
% plot3(FF(61:90,1), FF(61:90,2), FF(61:90,3),'bx');
% hold on
% plot3(FF(91:120,1), FF(91:120,2), FF(91:120,3),'yx');
% hold on
% plot3(FF(121:150,1), FF(121:150,2), FF(121:150,3),'rx');
% hold on
% plot3(FF(151:180,1), FF(151:180,2), FF(151:180,3),'cx');
% hold on
% plot3(FF(181:210,1), FF(181:210,2), FF(181:210,3),'mx');
% xlabel('eigenvector1');
% ylabel('eigenvector2');
% zlabel('eigenvector3');
% title('3 Principal dimensions explaining the most variance for all images');
% hold off

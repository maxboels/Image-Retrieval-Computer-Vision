% Descriptor
close all;
clear all;

%choose the number of dimensions
n_rows = 10;
m_columns = 10;

% Folders
DATASET_FOLDER = 'C:/Users/Administrator/Documents/SURREY CVRML/CV&PR/Lab/MSRC_ObjCategImageDatabase_v2';
OUT_FOLDER = 'C:/Users/Administrator/Documents/SURREY CVRML/CV&PR/Lab/descriptors';
OUT_SUBFOLDER='Grid_descriptor';
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));

allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic; %time
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./256; %read and normalize
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    F=function_Grid_descriptor(img, n_rows, m_columns); %descriptor
    save(fout,'F');
    toc %time
end

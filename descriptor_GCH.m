% Descriptor
close all;
clear all;
%choose the level of quantization
Q = 5;

% Folders
DATASET_FOLDER = 'C:/Users/Administrator/Documents/SURREY CVRML/CV&PR/Lab/MSRC_ObjCategImageDatabase_v2';
OUT_FOLDER = 'C:/Users/Administrator/Documents/SURREY CVRML/CV&PR/Lab/descriptors';
OUT_SUBFOLDER='GCH_descriptor/Q5';
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));

allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic; %time
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./256; %read and normalize
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    F=function_GCH(img, Q); %descriptor
    
    save(fout,'F');
    toc %time
end
close all;
%clear all; 
%Tune the number of Test Set (Queries)
NQueries = 4;
%% Folder with Input Images
DATASET_FOLDER = 'C:/Users/Administrator/Documents/SURREY CVRML/CV&PR/Lab/MSRC_ObjCategImageDatabase_v2';
%% Folder that holds the results
DESCRIPTOR_FOLDER = 'C:/Users/Administrator/Documents/SURREY CVRML/CV&PR/Lab/descriptors';
%% Select the descriptor to use for computing the distance
DESCRIPTOR_SUBFOLDER='PCA_descriptor';
% Then Select the Distance metric line 47
%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)
ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp'])); %access original images
for filenum=1:length(allfiles) % for loop over all files
    fname=allfiles(filenum).name; % name
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%descriptor path
    load(featfile,'F'); %load descriptor as F for each image
    ALLFILES{ctr}=imgfname_full; % put image path in all files cell
    ALLFEAT=[ALLFEAT ; F]; % add i descriptor into array with ALLFEAT 0:i
    ctr=ctr+1;
end

%% 2) Pick up the queryimg to compare different descriptors' performance (class 4: plane or 8: bike)
NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg = [437, 550, 529 ,353];
n = (NQueries*2)-1; % (n+1)/2= number of queries
j = 1;
dst=[]; %create empty array
for q = 1:2:n
    %% 3) Compute the distance of image to the query
    for i=1:NIMG %from 1 to 591
        candidate=ALLFEAT(i,:);
        query=ALLFEAT(queryimg(j),:);
    % Calculate the Distance between query and candidate
        thedst=function_Manhattan(query,candidate);
        dst(i, q:q+1) = [thedst i];  %increment rows with the dst and index i for 3 columns
    end
    j = j + 1;
    dst_all=sortrows(dst,q);  % sort the results
    %% 4) Visualise the results
    %% These may be a little hard to see using imgshow
    %% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)
    SHOW=15; % Show top 15 results
    topdst=dst_all(1:SHOW,q:q+1); %filter dst with first 15 distances
    outdisplay=[]; % outdisplay vector
    for i=1:size(topdst,1)
       img=imread(ALLFILES{topdst(i,2)});
       img=img(1:2:end,1:2:end,:); % make image a quarter size
       img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
       outdisplay=[outdisplay img];
    end
    figure()
    imshow(outdisplay);
    axis off;
end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This function creates train data set
%% It takes image path folder and log file path
%% as input. 
%% A structure filled with images and labels
%%  is returned and also saved in a file. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ imdb_train  ] = createTrainDataset(imageFolderPath)


%% dimension of patch
dimX = 400;
dimY = 400;
dimZ = 1;
strideX = 200;
strideY = 200;

imdb_train.meta = struct('classes',[],'set',[]);
imdb_train.images = struct('data',[],'label',[],'set',[]);
num_data = 10000;
imdb_train.images.data = single(zeros(dimX/2,dimY/2, num_data));
imdb_train.images.label = single(zeros( 1, num_data));
imdb_train.images.set = single(zeros(1, num_data));
imdb_train.meta.classes = {1,2};
imdb_train.meta.set = {1,2};
%% Path to save the training data
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria/data/train_data';
numberOfFolders = size(dir(path),1) - 2;
dataFolderName = fullfile(path,strcat('mitochondria_data-',num2str(numberOfFolders + 1)));
mkdir(dataFolderName);
%% create a log file to save file names from which 
%% training data is created. 

dataLogFile = fullfile(dataFolderName , 'log.txt');
fileID = fopen(dataLogFile,'w');
expDate = datetime('now');
fprintf(fileID, 'Date - %20s \n',char( cellstr(expDate)) );
fprintf(fileID, 'Data Number -  %d \n',(numberOfFolders + 1));

folderNames = dir(imageFolderPath);
counter = 0;

  fprintf(fileID, 'Filese used for creating Training data \n');
for i = 3:size(folderNames , 1)
    folderName = fullfile(imageFolderPath,folderNames(i).name);
    fileNames = dir ( folderName);
    for j = 3:45%size(fileNames,1)
        file = fullfile(folderName, fileNames(j).name);
        
        %% print the file name in log file
        fprintf(fileID, '%30s \n', fileNames(j).name);
        disp(fileNames(j).name)
        
        
        image = imread(file);
        imagergb = image(:,:,1:3);
        imageGray = rgb2gray(imagergb);
        [patches , centerOfPatches, count] = extractPatchFromImage(  imageGray ,dimX ,dimY,strideX, strideY);
        [augmentedPatches , augmentedCount] = augmentPatches(patches, dimX/2, dimY/2,  count);
        currentCount = counter + 1;
        endCount = counter + augmentedCount - 1;
           [imdb_train] = insertPatchesInImdb(augmentedPatches,currentCount,endCount, imdb_train , i-2);
%        if(i-2 == 1)
%         [imdb_train] = insertPatchesInImdb(augmentedPatches,currentCount,endCount, imdb_train , -1);
%        else
%          [imdb_train] = insertPatchesInImdb(augmentedPatches,currentCount,endCount, imdb_train , 1);
%        end
       
        counter = endCount;
        
    end
    
    
    
    
end

% remove mean in any case
% dataMean = mean(imdb_train.images.data(:,:,:,imdb_train.images.set==1), 4);
% imdb_train.images.data = bsxfun(@minus, imdb_train.images.data, dataMean);

fprintf(fileID, 'dimx  -  %d \n',dimX);
fprintf(fileID, 'dimy  -  %d \n',dimY);
fprintf(fileID, 'stridex  -  %d \n',strideX);
fprintf(fileID, 'stridey  -  %d \n',strideY);
fprintf(fileID, 'total number of patches  -  %d \n',counter);

disp(counter);
trainDataFile = fullfile(dataFolderName, 'train_data.mat');
save(trainDataFile,'-struct','imdb_train', '-v7.3');
disp('file saved');

end


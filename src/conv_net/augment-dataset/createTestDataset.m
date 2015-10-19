%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This function creates train data set
%% It takes image path folder and log file path
%% as input. 
%% A structure filled with images and labels
%%  is returned and also saved in a file. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ imdb_test  ] = createTestDataset(imageFolderPath)


%% dimension of patch
dimX = 200;
dimY = 200;
strideX = 200;
strideY = 200;

imdb_test.meta = struct('classes',[],'set',[]);
imdb_test.images = struct('data',[],'label',[],'set',[]);
num_data = 10;
imdb_test.images.data = single(zeros(dimX,dimY, num_data));
imdb_test.images.label = single(zeros( 1,num_data));
imdb_test.images.set = single(zeros(1, num_data));
imdb_test.meta.classes = {1,2};
imdb_test.meta.set = {1,2};
%% Path to save the training data
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria/data/test_data';
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

  fprintf(fileID, 'Filese used for creating Testing data \n');
for i = 3:size(folderNames , 1)
    folderName = fullfile(imageFolderPath,folderNames(i).name);
    fileNames = dir ( folderName);
    for j = 3:size(fileNames,1)
        file = fullfile(folderName, fileNames(j).name);
        
        %% print the file name in log file
        fprintf(fileID, '%30s \n', fileNames(j).name);
        disp(fileNames(j).name)
        
        
        image = imread(file);
        imagergb = image(:,:,1:3);
        imageGray = rgb2gray(imagergb);
        [patches , centerOfPatches, count] = extractPatchFromImage(  imageGray ,dimX ,dimY,strideX, strideY);   
        currentCount = counter + 1;
        endCount = counter + count ;
         [imdb_test] = insertPatchesInImdb(patches,currentCount,endCount, imdb_test , i-2 );
%        if(i-2 == 1)
%         [imdb_test] = insertPatchesInImdb(patches,currentCount,endCount, imdb_test , -1);
%        else
%         
%        end
       
        counter = endCount;
        
    end
    
    
    
    
end

% remove mean in any case
% dataMean = mean(imdb_test.images.data(:,:,:,imdb_test.images.set==1), 4);
% imdb_test.images.data = bsxfun(@minus, imdb_test.images.data, dataMean);

fprintf(fileID, 'dimx  -  %d \n',dimX);
fprintf(fileID, 'dimy  -  %d \n',dimY);
fprintf(fileID, 'stridex  -  %d \n',strideX);
fprintf(fileID, 'stridey  -  %d \n',strideY);
fprintf(fileID, 'total number of patches  -  %d \n',counter);

disp(counter);
trainDataFile = fullfile(dataFolderName, 'test_data.mat');
save(trainDataFile,'-struct','imdb_test', '-v7.3');
disp('file saved');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script projects patch level score
% on the image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

run(fullfile(fileparts(mfilename('fullpath')), ...
  '../../../matconvnet', 'matlab', 'vl_setupnn.m')) ;


%% Provide the path of folder where images are kept for prediction
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/Huh6';
%%%%%%%%%%%%%

destPath = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/Huh6-projected';

%%%%%%%%%%%%%%% Load the Model
net = load('/home/bug/git/Documents/third_sem/IDP/Mitochondria/data/CNN_experiments/exp_18_lr/cnnmit.mat') ;
%%%%%%%%%%%%%%%

fnames = dir(path);
n =  size(fnames);
prob = zeros(n);
dimX = 400;
dimY = 400 ;
dimZ = 1;
strideX = 200;
strideY = 200;
counter = 1;



imdb_test.meta = struct('classes',[],'set',[]);
imdb_test.images = struct('data',[],'label',[],'set',[]);
num_data = 10;
% imdb_test.images.data = single(zeros(dimX,dimY, num_data));
imdb_test.images.data = single(zeros(dimX/2,dimY/2, num_data));
imdb_test.images.label = single(zeros( 1, num_data));
imdb_test.images.set = single(zeros(1, num_data));
imdb_test.meta.classes = {1,2};
imdb_test.meta.set = {1,2};

   
for K = 3:n
    fileName = fullfile(path,fnames(K).name);
    image = imread(fileName);
    imageThreeChannel = image(:,:,1:3);
    imageGray = rgb2gray(imageThreeChannel);
    [patches , centerOfPatches, count] = extractPatchFromImage(  imageGray ,dimX ,dimY,strideX, strideY);   
       
    
%     [ augmentedPatches , augmentedCount] = augmentPatches(patches , count);
    

  %  factor =  (augmentedCount -1 )/( count -1);
%     counter = 1;
%     cancerProbability = zeros(count-1,1);
    
 patchesProbabilities = zeros(count ,1);

     for j = 1:count
        
       patchesProbabilities(j) = predictPatch(net,patches(:,:,j) );
%        if( cancerProbability(i) < 0.5)
%            counter = counter + 1;
     
       
            
    end
    
    
    imageWithProbability = insertText(imageGray,centerOfPatches(1:count, :), patchesProbabilities(1:count,1),'AnchorPoint','LeftBottom');
    [pathstr,name,ext] = fileparts(fileName);
    finalFileName = fullfile(destPath, name);
    imwrite(imageWithProbability,finalFileName,'png');
    
    
    
end

% acc = counter/((n(1)-2) * (count -1));
% disp(n(1) -2);
% disp(counter);
% disp(count -1);
% disp(acc);
% 
% patch_level = reshape(   patchesProbabilities , ( n(1) - 2) *20 ,  12);

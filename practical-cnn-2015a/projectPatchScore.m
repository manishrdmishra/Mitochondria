%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script projects patch level score
% on the image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setup ;

%% Provide the path of folder where images are kept for prediction
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_Predict_HR/Leber';
%%%%%%%%%%%%%

destPath = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/Huh6-projected';

%%%%%%%%%%%%%%% Load the Model
net = load('/home/bug/git/Documents/third_sem/IDP/Mitochondria/practical-cnn-2015a/data/CNN_experiments/exp_21_hr/cnnmit.mat') ;
%%%%%%%%%%%%%%%

fnames = dir(path);
n =  size(fnames);
prob = zeros(n);
dimx = 250;
dimy = 250 ;
stridex = 250;
stridey = 250;
counter = 1;
    patchesProbabilities = zeros(( n(1) -2 ) *240 ,1);
for K = 3:n
    fileName = fullfile(path,fnames(K).name);
    image = imread(fileName);
    imageThreeChannel = image(:,:,1:3);
    imageGray = rgb2gray(imageThreeChannel);
    
    [patches , centerOfPatches, count] = extractPatchFromImage(imageGray,dimx ,dimy,stridex,stridey );
    
    [ augmentedPatches , augmentedCount] = augmentPatches(patches , count);
    

  %  factor =  (augmentedCount -1 )/( count -1);
%     counter = 1;
%     cancerProbability = zeros(count-1,1);
    
    
    for i = 1:augmentedCount-1
        
       patchesProbabilities(counter) = predictPatch(net,augmentedPatches(:,:,i) );
%        if( cancerProbability(i) < 0.5)
           counter = counter + 1;
%        end
       
            
    end
    
    
%     imageWithProbability = insertText(imageGray,centerOfPatches, cancerProbability,'AnchorPoint','LeftBottom');
%     [pathstr,name,ext] = fileparts(fileName);
%     finalFileName = fullfile(destPath, name);
%     imwrite(imageWithProbability,finalFileName,'png');
    
    
    
end

% acc = counter/((n(1)-2) * (count -1));
% disp(n(1) -2);
% disp(counter);
% disp(count -1);
% disp(acc);

patch_level = reshape(   patchesProbabilities , ( n(1) - 2) *20 ,  12);

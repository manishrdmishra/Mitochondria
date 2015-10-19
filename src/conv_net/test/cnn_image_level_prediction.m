run(fullfile(fileparts(mfilename('fullpath')), ...
  '../../../matconvnet', 'matlab', 'vl_setupnn.m')) ;


%%%%%%%%%%%%%
%% create the data structure to store the patches
%%%%%%%%%%%%%

num_data = 100;
dimX =  200;
dimY = 200;
strideX = 200; 
strideY = 200;
imdb_test.meta = struct('classes',[],'set',[]);
imdb_test.images = struct('data',[],'label',[],'set',[]);

% imdb.images.label = single(zeros(2, num_data));

imdb_test.meta.classes = {1,2};
imdb_test.meta.set = {1,2};
%%%%%%%%%%%%%%

%% Provide the path of folder where images are kept for prediction
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_Predict_LR/Tumor';
%%%%%%%%%%%%%


%%%%%%%%%%%%%%
%% Open the file to write the result into it
%%%%%%%%%%%%%%
fileID = fopen('/home/bug/git/Documents/third_sem/IDP/Mitochondria/data/result.txt','w');
fprintf(fileID, '%20s \n\n',' Predition in Tumor folder  ');
fprintf(fileID, '%20s \n\n','Positive - Cancer');

 fprintf(fileID,'%-30s %-20s %-20s %-20s %-20s\n','File Name', 'Total Patch','Predited class', 'probability cancer','std deviation');
%%%%%%%%%%%%%%%
%% Load the Model
net = load('/home/bug/git/Documents/third_sem/IDP/Mitochondria/data/CNN_experiments/exp_18_lr/cnnmit.mat') ;
%%%%%%%%%%%%%%%

num_positive = 0;
num_negative = 0;

fnames = dir(path);
n =  size(fnames);
prob = zeros(n);
for K = 3:n
    fileName = fullfile(path,fnames(K).name);

    image = imread(fileName);
%     imageThreeChannel = image(:,:,1);
%     imageGray = rgb2gray(imageThreeChannel);
    imageGray = image(:,:,1);
    [patchesProbabilities, meanProbability,stdProbability] = predictImage(image, net,dimX, dimY, strideX, strideY );
    
    if( meanProbability > (0.5))
    class = 'Positive';
    num_positive = num_positive + 1;
    else
      class = 'Negative';
      num_negative = num_negative + 1;
    end
    fprintf(fileID,'%-30s  %-20d  %-20s  %-20f %-20f\n',fnames(K).name, size(patchesProbabilities,2),class, meanProbability, stdProbability);
end
fprintf(fileID, '\n%20s %6d \r\n','Total positive :', num_positive);
fprintf(fileID, '%20s %6d \r\n','Total negative :', num_negative);
% hold on;
%scatter(1:K, prob,color);
fclose(fileID);



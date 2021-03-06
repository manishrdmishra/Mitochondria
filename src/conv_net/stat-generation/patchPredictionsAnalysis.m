%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This script is used to analyse the patch 
%% level predictions. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%% Provide the path of folder where images are kept for prediction
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_Predict_HR/Tumor';
%%%%%%%%%%%%%


%%%%%%%%%%%%%%
%% Open the file to write the result into it
%%%%%%%%%%%%%%
fileID = fopen('predictions.txt','w');
fprintf(fileID, '%20s \n\n',' Predition in Huh6 folder  ');
fprintf(fileID, '%20s \n\n','Positive - Cancer');

 fprintf(fileID,'%-30s %-20s %-20s  %-20s %-20s %-20s\n','File Name', 'Total Patch', 'Predicted Positve','Predited class','Probability health', 'probability cancer');
%%%%%%%%%%%%%%%
%% Load the Model
net = load('/home/bug/git/Documents/third_sem/IDP/Mitochondria/data/CNN_experiments/exp_17_mix/cnnmit.mat') ;
%%%%%%%%%%%%%%%

num_positive = 0;
num_negative = 0;
label = 2;
MAX = 1;
fnames = dir(path);
n =  size(fnames);
dimX = 250;
dimY = 250;
strideX = 250;
strideY = 250;

 
%for i = 1:size(imdb_test.images.data,3)
 for K = 3:n
     fileName = fullfile(path,fnames(K).name);
      image = imread(fileName);
       imageThreeChannel = image(:,:,1);
%     imageGray = rgb2gray(imageThreeChannel);
    imageGray = image(:,:,1);
    [patchesProbabilities, meanProbability,stdProbability] = predictImage(image, net,dimX, dimY, strideX, strideY );
    
 end
%     count = 1;
%     imdb_test.images.data = single(zeros(dimx,dimy, num_data));
%     imdb_test.images.label = single(zeros(1, num_data));
%     imdb_test.images.set = single(zeros(1, num_data));
%     [imdb_test,count] = cnnextractPatch(fileName,dimx , dimy, imdb_test , count, label, MAX);
    %    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
    
    
%     disp(count);
%     disp(K);
%     positive_counter = 0;
%      prob_healthy = 0;
%       prob_cancer = 0;
%        prob_cancer = zeros(count - 1,1);
%         prob_healthy  =  zeros(count-1, 1);
% fprintf(fileID, '\n %30s:  patch predictions \n', fnames(K).name);

%     for i  = 1:count - 1
        % load and preprocess an image
      
%         im = imdb_test.images.data(:,:,i);
%         im_ = single(im) ; % note: 255 range
%         %     im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
%         %     im_ = im_ - net.normalization.averageImage ;
%         
%         % run the CNN
%         res = vl_simplenn(net, im_) ;
%         
%         % show the classification result
%         
%         scores = squeeze(gather(res(end).x)) ;
%         patch_probability(i) = exp(scores(2) - scores(1)) / ( exp(scores(2) - scores(1)) + exp( scores(1) - scores(2)));
%         prob_cancer =   prob_cancer + patch_probability;
%         prob_healthy =    prob_healthy + exp(scores(1) - scores(2)) / ( exp(scores(2) - scores(1)) + exp( scores(1) - scores(2)));
%         prob_healthy =  prob_healthy + 1 / ( 1 + exp(-scores(1)));
%         prob_cancer = prob_cancer + 1 / ( 1 + exp( -scores(2)));
       % disp(exp(scores(2) - scores(1)) / ( exp(scores(2) - scores(1)) + exp( scores(1) - scores(2))));
    
      
     
%        patch_level_prob(counter) = patch_probability;
%        counter = counter + 1;
       
      %  fprintf(fileID, ' %f ',exp(scores(2) - scores(1)) / ( exp(scores(2) - scores(1)) + exp( scores(1) - scores(2))));
%         [bestScore, best] = max(scores) ;
%         if(best == 2)
%             positive_counter = positive_counter + 1;
%         end
%         
%     end
%     prob_healthy = prob_healthy / (count -1);
%     prob_cancer = prob_cancer/ (count -1);
%       prob(K) = prob_cancer;
%     if( prob_cancer > prob_healthy)
%     class = 'Positive';
%     num_positive = num_positive + 1;
%     else
%       class = 'Negative';
%       num_negative = num_negative + 1;
%     end
%     fprintf(fileID,'%-30s %-20d %-20d  %-20s %-20f %-20f\n',fnames(K).name, count, positive_counter,class,prob_healthy, prob_cancer);
%end
% fprintf(fileID, '\n%20s %6d \r\n','Total positive :', num_positive);
% fprintf(fileID, '%20s %6d \r\n','Total negative :', num_negative);

% fclose(fileID);
% 
%  patch_level = reshape(patch_level_prob,n(1)* 16 , 15);

  

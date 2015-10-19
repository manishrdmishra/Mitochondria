run(fullfile(fileparts(mfilename('fullpath')), ...
  '../../../matconvnet', 'matlab', 'vl_setupnn.m')) ;


%% Load the Model
net = load('/home/bug/git/Documents/third_sem/IDP/Mitochondria/data/CNN_experiments/exp_22/cnnmit.mat') ;
%%%%%%%%%%%%%%%
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/predict';

% fileID = fopen('result_2.txt','w');
% fprintf(fileID, '%20s \n\n',' Predition in Tumor folder  ');
folders = dir(path);
m = size(folders , 1);


color = [ 0 0 1;
    0 1 0;
    0 1 1;
    1 0 0;
    1 0 1;
    1 1 0
    0 0 0
    0.5 0 0];
markerType = ['d', 'o', '*','x','s','^','<','>'];
y = zeros(m-2,2);

dimX = 400;
dimY = 400;
strideX = 200;
strideY = 200;


for j = 3:m
    dname = fullfile(path,folders(j).name);
%     fprintf(fileID, ' \n %20s \n\n',dname );
    disp(dname);
    
    fnames = dir(dname);
    n =  size(fnames);
    images_prob = zeros( n(1)-2,1);
   
    c = 1;
    
    
    patches_std = zeros((n(1)-2), 1);
    for K = 3:n
        fileName = fullfile(dname,fnames(K).name);
            image = imread(fileName);
%     imageThreeChannel = image(:,:,1);
%     imageGray = rgb2gray(imageThreeChannel);
    imageGray = image(:,:,1);
    [patchesProbabilities, meanProbability,stdProbability] = predictImage(image, net,dimX, dimY, strideX, strideY );
    images_prob(K-2) = meanProbability;
    patches_std(K -2) = stdProbability;
    
    end
    %% uncomment this to plot bar graph of image level mean and its std
%       y(j- 2 , 1) = mean(images_prob);
%     y(j-2 , 2) = std(images_prob);

%% uncomment this to plot std of patch level and its mean

      y(j- 2 , 1) = mean(patches_std);
    y(j-2 , 2) = std(patches_std);

end
 bar(1:m-2 , y(1:m-2,1) , 'b');
hold on; errorbar ( 1:m-2 , y(1:m-2,1) , y(1:m-2,2),'b*');
Labels = {'Brain','Fao','H4IIE', 'HepG2', 'HepT1','Huh6', 'Mhc2', 'Mhic1' ,'T-Healthy','T-Tumor'};
set(gca, 'XTick', 1:10, 'XTickLabel', Labels);

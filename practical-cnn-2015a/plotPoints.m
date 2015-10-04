setup;

num_data = 100;
dimx =  250;
dimy = 250;
imdb_test.meta = struct('classes',[],'set',[]);
imdb_test.images = struct('data',[],'label',[],'set',[]);

%% Load the Model
net = load('/home/bug/git/Documents/third_sem/IDP/Mitochondria/practical-cnn-2015a/data/CNN_experiments/exp_17/cnnmit.mat') ;
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


for j = 3:m
    dname = fullfile(path,folders(j).name);
%     fprintf(fileID, ' \n %20s \n\n',dname );
    disp(dname);
    
    fnames = dir(dname);
    n =  size(fnames);
    prob = zeros( n(1)-2,1);
    hprob = zeros(n);
    c = 1;
    prob_cancer = zeros((n(1)-2) * ( 240 ), 1);
    
    std_cancer = zeros((n(1)-2), 1);
    for K = 3:n
        fileName = fullfile(dname,fnames(K).name);
        count = 1;
        imdb_test.images.data = single(zeros(dimx,dimy, num_data));
        imdb_test.images.label = single(zeros(1, num_data));
        imdb_test.images.set = single(zeros(1, num_data));
        label = 0;
        MAX = 0;
        [imdb_test,count] = cnnextractPatch(fileName,dimx , dimy, imdb_test , count, label, MAX);
        %    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
        
        
        % disp(count);
        %disp(K);
        positive_counter = 0;
        prob_healthy = 0; %zeros(count - 1,1);
        prob_cancer = 0; %zeros(n-2 * count, 1);
        prb_cancer = zeros(count - 1,1);
        prb_healthy =  zeros(count-1, 1);
        for i  = 1:count - 1
            % load and preprocess an image
            im = imdb_test.images.data(:,:,i);
            im_ = single(im) ; % note: 255 range
            %     im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
            %     im_ = im_ - net.normalization.averageImage ;
            
            % run the CNN
            res = vl_simplenn(net, im_) ;
            
            % show the classification result
            
            scores = squeeze(gather(res(end).x)) ;
            prob_healthy = prob_healthy +   1 / ( 1 + exp(-scores(1)));
            prob_cancer = prob_cancer +  1 / ( 1 + exp( -scores(2)));
          %  prb_cancer(i) = 1/ ( 1 + exp( -scores(2)));
           prb_cancer(i) = exp(scores(2) - scores(1)) / ( exp(scores(2) - scores(1)) + exp( scores(1) - scores(2)));
               prb_healthy(i) = exp(scores(1) - scores(2)) / ( exp(scores(2) - scores(1)) + exp( scores(1) - scores(2)));
         %   prb_healthy(i) = 1/ ( 1 + exp( -scores(1)));
            %
            %             prob_cancer(c) =   1 / ( 1 + exp( -scores(2)));
            %
            %             c = c + 1;
            
            
            
            
            
        end
        prob_healthy = prob_healthy / count;
        prob_cancer = prob_cancer/ count;
        prob(K - 2) = prob_cancer;
        hprob(K) = prob_healthy;
        std_cancer(K-2) = std(prb_cancer);
%         fprintf(fileID, ' \n %20s \n' , fileName);
%         fprintf(fileID, '%10s  ', 'cancer score - ');
%        
%         
%         fprintf(fileID, '%6.4f ', prb_cancer);
%         fprintf(fileID, ' \n %10s  ', 'healthy score - ');
%         fprintf(fileID, '%6.4f ',prb_healthy);
      
        
        
        %         c1 = rand();
        %         c2 = rand();
        %         c3 = rand();
        % gscatter(1:count, prob_cancer, [], color(j-2,1:end),markerType(j-2));
        %        hold on;
        
        
    end
    
    %     c = c-1;
    
    %            gscatter(1:n(1)-2, prob(1:n(1)-2), [],color(j-2,1:end),markerType(j-2));
    %            hold on;
    %            axis([1 70 0 1]);
    %
    
    y(j- 2 , 1) = mean(std_cancer);
    y(j-2 , 2) = std(std_cancer);
%      y(j- 2 , 1) = mean(prob);
%     y(j-2 , 2) = std(prob);
    %    y(j - 2, 2) = std(prob);
    %     y(j- 2 , 3) = mean(hprob(2:end));
    %     y(j - 2, 4) = var(hprob(2:end));
    
    %             hold on;
    %             scatter(1:K-2, prob,20, color(j-2,:),markerType(j-2,:));
    
    
end

%legend({'Fao','H4IIE', 'HepG2' , 'HepT1','mhc2', 'mhic1','Train'});
 bar(1:m-2 , y(1:m-2,1) , 'b');
hold on; errorbar ( 1:m-2 , y(1:m-2,1) , y(1:m-2,2),'b*');
Labels = {'Brain','Fao','H4IIE', 'HepG2', 'HepT1','Huh6', 'Mhc2', 'Mhic1' ,'T-Healthy','T-Tumor'};
set(gca, 'XTick', 1:10, 'XTickLabel', Labels);


% figure; bar(1:10,synMean(1:10),'b');
%
% hold on; errorbar(1:10,synMean(1:10),synStd(1:10),'b*');
%
% hold on; bar(12:17,synMean(11:16),'g');
%
% hold on; errorbar(12:17,synMean(11:16),synStd(11:16),'g*');
%
% legend('WT','','AD','');
%
% set(gca,'XTickLabel','')


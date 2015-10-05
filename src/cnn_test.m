% install and compile MatConvNet (needed once)
% untar('http://www.vlfeat.org/matconvnet/download/matconvnet-1.0-beta12.tar.gz') ;
% cd matconvnet-1.0-beta12
% run matlab/vl_compilenn

% download a pre-trained CNN from the web (needed once)

% setup MatConvNet
%     run  matlab/vl_setupnn

% load the pre-trained CNN
net = load('/home/bug/git/Documents/third_sem/IDP/Mitochondria/practical-cnn-2015a/data/experiment/cnnmit.mat') ;

confusion = zeros(2,2);
count_1 = 0;
count_2 = 0;
imdb = load('data/mit_new_test.mat') ;
imageMean = mean(imdb.images.data(:)) ;
imdb.images.data = imdb.images.data - imageMean ;

for i  = 1:size(imdb.images.data , 3) - 1
    % load and preprocess an image
    im = imdb.images.data(:,:,i);
    im_ = single(im) ; % note: 255 range
    %     im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
    %     im_ = im_ - net.normalization.averageImage ;
    
    % run the CNN
    res = vl_simplenn(net, im_) ;
    
    % show the classification result
    scores = squeeze(gather(res(end).x)) ;
    [bestScore, best] = max(scores) ;
    label = imdb.images.label(i);
    confusion(label,best) = confusion(label, best) + 1;
    
    
    if(label == 1)
        count_1 = count_1 + 1;
    else
        count_2 =  count_2 + 1;
    end
%     if(label~= best)
%         figure(1) ; clf ; imagesc(im) ;
%     end
    %     title(sprintf('%s (%d), score %.3f',...
    %     net.classes.description{best}, best, bestScore)) ;
end
disp(confusion);
disp(count_1);
disp(count_2);

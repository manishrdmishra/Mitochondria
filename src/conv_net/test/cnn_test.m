% function [confusionMatrix ] = cnn_test(net,testImageFolder)

% net = load(net) ;
run(fullfile(fileparts(mfilename('fullpath')), ...
  '../../../matconvnet', 'matlab', 'vl_setupnn.m')) ;
net  = load('/home/bug/git/Documents/third_sem/IDP/Mitochondria/data/CNN_experiments/exp_18_lr/cnnmit.mat') ;

confusionMatrix = zeros(2,2);
count_1 = 0;
count_2 = 0;
imdb = load('/home/bug/git/Documents/third_sem/IDP/Mitochondria/data/test_data/mitochondria_data-6/test_data.mat') ;
% imageMean = mean(imdb.images.data(:)) ;
% imdb.images.data = imdb.images.data - imageMean ;

for i  = 1:size(imdb.images.data , 3)
    % load and preprocess an image
    im1 = imdb.images.data(:,:,i);


    im_ = single(im1) ; % note: 255 range
    %     im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
    %     im_ = im_ - net.normalization.averageImage ;
    
    % run the CNN
    res = vl_simplenn(net, im_) ;
    
    % show the classification result
    scores = squeeze(gather(res(end).x)) ;
    [bestScore, best] = max(scores) ;
    label = imdb.images.label(i);
    confusionMatrix(label,best) = confusionMatrix(label, best) + 1;
    
    
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
disp(confusionMatrix);
disp(count_1);
disp(count_2);
% end

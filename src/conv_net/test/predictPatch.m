%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes a patch as input
% and returns the return the probability of cancer.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [cancerProbability] = predictPatch(net,patch)

patch_ = single(patch) ; % note: 255 range
%     im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
%     im_ = im_ - net.normalization.averageImage ;

% run the CNN
res = vl_simplenn(net, patch_) ;

% show the classification result

scores = squeeze(gather(res(end).x)) ;

cancerProbability = exp(scores(2) - scores(1)) / (( exp(scores(2) - scores(1)) + exp( scores(1) - scores(2))));
end
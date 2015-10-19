%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes gray image as input
% it predicts probability for each patch and
% find mean and deviation of all patches in
% a given image. The mean will be considered
% as the probability of the whole image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [patchesProbabilities, meanProbability,stdProbability] = predictImage(image, net, dimX, dimY, strideX, strideY)

 [patches ,centerOfPatches, count ] = extractPatchFromImage(image,dimX ,dimY,strideX, strideY);
    
   patchesProbabilities = zeros(1, count);
    
    for i  = 1:count
      patchesProbabilities(1, i) = predictPatch(net,patches(:,:,i));
        
    end
   meanProbability = mean(patchesProbabilities);
   stdProbability = std(patchesProbabilities);
end

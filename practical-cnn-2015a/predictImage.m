%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes gray image as input
% it predicts probability for each patch and
% find mean and deviation of all patches in
% a given image. The mean will be considered
% as the probability of the whole image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [patchesProbabilities, meanProbability,stdProbability] = predictImage(image)

 [patches ,centerOfPatches, count ] = extractPatchFromImage(image,dimx ,dimy,stride);
    
   patchesProbabilities = zeros(count - 1,1);
    
    for i  = 1:count - 1
      patchesProbabilities(i) = predictPatch(net,patches(:,:,i));
        
    end
   meanProbability = mean(cancerProbability);
   stdProbability = std(cancerProbability);
end

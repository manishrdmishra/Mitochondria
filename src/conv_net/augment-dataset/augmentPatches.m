%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function augments extracted patches from a given image.
% Augmentation is done by rotating and flipping the patch.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [augmentedPatches , augmentedCount] = augmentPatches(patches, dimX, dimY,  count)

AUGMENTATION_FACTOR = 12;
augmentedPatches = zeros(dimY, dimX, count * AUGMENTATION_FACTOR);

augmentedCount = 0;
for i = 1:count
    
    
    for j= 0:90:270
        
        %% store rotated patch and store
        tempr = patches(:,:,i);
        augmentedCount = augmentedCount + 1;
        augmentedPatches(:,:,augmentedCount) = tempr;
        
        
        %% flip the patch left to right and store
        
        templr =  fliplr(tempr);
        augmentedCount = augmentedCount + 1;
        augmentedPatches(:,:,augmentedCount) = templr;
        
        
        %% flips the patch up to down and store
        
        tempud =  flipud(tempr);
        augmentedCount = augmentedCount + 1;
        augmentedPatches(:,:,augmentedCount) = tempud;
        
    end
    
end
end


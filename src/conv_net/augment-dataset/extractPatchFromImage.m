%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function extracts patches from a given image
% It also calculates the center of each patch
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [patches , centerOfPatches, count] = extractPatchFromImage(image,dimX, dimY ,strideX, strideY)
% sizeOfImage = size(image);
% numberOfPatches = floor( (sizeOfImage(1) * sizeOfImage(2) )/ (stride * stride )) - 1 ;
sizeY = size(image,1);
sizeX = size(image,2);
numberOfPatchesY =  floor ( ( ( ( sizeY - ( dimY )) / strideY )  + 1) );
numberOfPatchesX = floor ( ( ( ( sizeX - (dimX)) / strideX ) + 1) );
numberOfPatches = numberOfPatchesY * numberOfPatchesX;

%% used the formulae T = a + (n -1 ) * d

endY = ( dimY + (numberOfPatchesY -1 ) * strideY) - strideY ;
endX =  ( dimX + (numberOfPatchesX - 1)* strideX ) - strideX ;



%% if resize is require then adjust the size of patches accrodingly 
patches = single(zeros(dimY,dimX,numberOfPatches));
%patches = single(zeros(dimY/2,dimX/2,numberOfPatches));

centerOfPatches = zeros(numberOfPatches,2);
count = 0;

for i = 1:( strideY ):(endY)
    for j = 1:( strideX ) :(endX)
        count =  count + 1;

        % if resize is not require then comment this line and uncomment the aboe line
        patches(:,:,count) = image(i:i+dimY -1  , j:j+dimX - 1);
         %patches(:,:,count) = imresize(image(i:i+dimY -1  , j:j+dimX - 1),0.5);
        

        centerOfPatches(count,1) = j + dimX/2;
        centerOfPatches(count,2) =  i + dimY/2;
        
        
    end
end

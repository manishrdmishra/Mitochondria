%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function extracts patches from a given image
% It also calculates the center of each patch
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [patches , centerOfPatches, count] = extractPatchFromImage(image,dimX ,dimY,strideX, strideY)
% sizeOfImage = size(image);
% numberOfPatches = floor( (sizeOfImage(1) * sizeOfImage(2) )/ (stride * stride )) - 1 ;
sizeY = size(image,1);
sizeX = size(image,2);
numberOfPatchesY =  floor ( ( ( ( sizeY - ( dimY )) / strideY )  + 1) );
numberOfPatchesX = floor ( ( ( ( sizeX - (dimX)) / strideX ) + 1) );
numberOfPatches = numberOfPatchesY * numberOfPatchesX;
patches = zeros(dimY,dimX,numberOfPatches);
centerOfPatches = zeros(numberOfPatches,2);
count = 1;

for i = 1:( strideY ):(dimY * numberOfPatchesY )
    for j = 1:( strideX ) :(dimX * numberOfPatchesX )
        patches(:,:,count) = image(i:i+dimY -1  , j:j+dimX - 1);
        centerOfPatches(count,1) = j + dimX/2;
        centerOfPatches(count,2) =  i + dimY/2;  
        count =  count + 1;
        
    end
end

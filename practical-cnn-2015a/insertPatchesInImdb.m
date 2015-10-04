function [imdb] = insertPatchesInImdb(augmentedPatches,augmentedCount,imdb , label )

num = 5;
for i = 1:augmentedCount
    
    imdb.images.data(:,:,i) = augmentedPatches(:,:,i);
    imdb.images.label(1,i) = label;
    b = mod(count,num);
    if( b == 0 )
        imdb.images.set(i) = 2;
    else
        imdb.images.set(i) = 1;
    end
    
    
end
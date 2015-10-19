function [imdb] = insertPatchesInImdb(patches,currentCount ,endCount,imdb , label )

num = 5;
counter = 1; 
for i = currentCount:1:endCount
    
    imdb.images.data(:,:,i) = patches(:,:,counter);
    counter = counter + 1;
    imdb.images.label(1, i) = label;
    b = mod(i,num);
    if( b == 0 )
        imdb.images.set(1, i) = 2;
    else
        imdb.images.set(1, i) = 1;
    end
    
    
end
function [imdb , count] = augmentImages(fileName,rotationAngle , imdb , count, label, MAX)

img = imread(fileName);
img = img(:,:,1:3);
img = rgb2gray(img);
% figure ;
% imshow(img);
img = imresize(img,[50,50]);

for j = 0:rotationAngle:360
    
    
    lurot= imrotate(img,j,'nearest','crop');
    luflip = fliplr(img);
    luflipdr = flipud(img);
    imdb.images.data(:,:,count) = single(lurot);
    imdb.images.label(count) = label;
    b = mod(count,3);
    if( b == 0 )
        imdb.images.set(count) = 2;
    else
        imdb.images.set(count) = 1;
    end
    count = count + 1;
    
    b = mod(count,3);
    if( b == 0 )
        imdb.images.set(count) = 2;
    else
        imdb.images.set(count) = 1;
    end
    imges.data(:,:,count) = single(luflip);
    imdb.images.label(count) = label;
    
     count = count + 1;
     
      b = mod(count,3);
    if( b == 0 )
        imdb.images.set(count) = 2;
    else
        imdb.images.set(count) = 1;
    end
    imges.data(:,:,count) = single(luflipdr);
    imdb.images.label(count) = label;
    
     count = count + 1;
     
      b = mod(count,3);
    if( b == 0 )
        imdb.images.set(count) = 2;
    else
        imdb.images.set(count) = 1;
    end
    imges.data(:,:,count) = single(img);
    imdb.images.label(count) = label;
     
    
end

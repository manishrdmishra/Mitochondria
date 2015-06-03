function [imdb , count] = augmentImages(fileName,rotationAngle , imdb , count, label, MAX)

img = imread(fileName);
img = img(:,:,1:3);
img = rgb2gray(img);
% figure ;
% imshow(img);
img = imresize(img,[200,200]);

for j = 1:rotationAngle:360
    if(count > MAX )
     break;
    end;
    lurot= imrotate(img,j,'nearest','crop');
    luflip = fliplr(img);
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
    
end

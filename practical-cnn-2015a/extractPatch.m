function [imdb , count] = extractPatch(fileName,dimx , dimy, imdb , count, label, MAX)
img = imread(fileName);
img = img(:,:,1:3);
img = rgb2gray(img);
for i = 1:dimy:size(img,1) -dimy
    for j = 1:dimx:size(img,2) -dimx
        temp = img(i:i+dimx -1  , j:j+dimy - 1);
        imdb.images.data(:,count) = temp(:);
        imdb.images.label(1,count) = label;
        imdb.images.label(2,count) = 1 - label;
        count =  count + 1;
        if( count > MAX)
            break;
        end
    end
end
function [imdb , count] = cnnextractPatch(fileName,dimx , dimy, imdb , count, label, MAX)
img = imread(fileName);
img = img(:,:,1:3);
img = rgb2gray(img);
num = 5;
for i = 1:dimy:size(img,1) -dimy
    for j = 1:dimx:size(img,2) -dimx
        temp = img(i:i+dimx -1  , j:j+dimy - 1);
        %         imdb.images.data(:,count) = temp(:);
        imdb.images.data(:,:, count) = temp;
        imdb.images.label(1,count) = label;
%         imdb.images.label(2,count) = 1 - label;
         b = mod(count,num);
    if( b == 0 )
        imdb.images.set(count) = 2;
    else
        imdb.images.set(count) = 1;
    end
    
    
        
        
        count =  count + 1;
        
        %flip the image
        templr =  fliplr(temp);
        %         imdb.images.data(:,count) = templr(:);
        imdb.images.data(:,:,count) = templr;
        imdb.images.label(1,count) = label;
%         imdb.images.label(2,count) = 1 - label;
        
         b = mod(count,num);
    if( b == 0 )
        imdb.images.set(count) = 2;
    else
        imdb.images.set(count) = 1;
    end
    
    
    
    
        count = count + 1;
        
        
        
        %flip the image up down
        templd =  flipud(temp);
        %         imdb.images.data(:,count) = templd(:);
        imdb.images.data(:,:, count) = templd;
        imdb.images.label(1,count) = label;
%         imdb.images.label(2,count) = 1 - label;
        
         b = mod(count,num);
    if( b == 0 )
        imdb.images.set(count) = 2;
    else
        imdb.images.set(count) = 1;
    end
    
    
    
        
        count = count + 1;
        
        
        %rotate the flipped image by 90 degre
        tempr =  imrotate(temp,90,'nearest','crop');
    
        imdb.images.data(:,:,count) = tempr;
        imdb.images.label(1,count) = label;
%         imdb.images.label(2,count) = 1 - label;
        
         b = mod(count,num);
    if( b == 0 )
        imdb.images.set(count) = 2;
    else
        imdb.images.set(count) = 1;
    end
    
        
        count = count + 1;
        
        
         %rotate the flipped image by 270 degre
%         tempr =  imrotate(temp,270,'nearest','crop');
%     
%         imdb.images.data(:,:,count) = tempr;
%         imdb.images.label(1,count) = label;
% %         imdb.images.label(2,count) = 1 - label;
%         
%          b = mod(count,num);
%     if( b == 0 )
%         imdb.images.set(count) = 2;
%     else
%         imdb.images.set(count) = 1;
%     end
    
%      count = count + 1;   
    end
end
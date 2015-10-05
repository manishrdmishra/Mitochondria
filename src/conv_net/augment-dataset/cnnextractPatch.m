%%%%%%%%%%%%%%%%%%%%%%%%%
%% This function is used to extract 
%% and augment patches. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [imdb , count] = cnnextractPatch(fileName,dimx , dimy, imdb , count, label, MAX)
img = imread(fileName);
% img = img(:,:,1:3);
%img = rgb2gray(img);
stride = 200;
for i = 1:dimx:size(img,1) -dimy
    for j = 1:dimx:size(img,2) -dimx
        temp = img(i:i+dimx -1  , j:j+dimy - 1);
        %         imdb.images.data(:,count) = temp(:);
        
        
        [imdb, count ] =  insertPatch(imdb,count,temp,label);
        
        
        count =  count + 1;
        
        %flip the image
        templr =  fliplr(temp);
        %         imdb.images.data(:,count) = templr(:);
        
        [imdb, count ] =  insertPatch(imdb,count,templr,label);
        
        
        
        count = count + 1;
        
        
        
        %flip the image up down
        templd =  flipud(temp);
        %         imdb.images.data(:,count) = templd(:);
        
        [imdb, count ] =  insertPatch(imdb,count,templd, label);
        
        
        count = count + 1;
        
        
        %rotate the  image by 90 degre and flip
        
        for i = 1:90:270 
            
            tempr =  imrotate(temp,i,'nearest','crop');
            
            [imdb, count ] =  insertPatch(imdb,count,tempr , label);
            
            count = count + 1;
            
            
            templr =  fliplr(tempr);
            %         imdb.images.data(:,count) = templr(:);
            
            [imdb, count ] =  insertPatch(imdb,count,templr,label);
            
            count = count + 1;
            
            templd =  flipud(tempr);
            %         imdb.images.data(:,count) = templd(:);
            
            [imdb, count ] =  insertPatch(imdb,count,templd, label);
            
            
            count = count + 1;
            
        end
        
%         %rotate the flipped image by  180  degre
%         tempr =  imrotate(temp,180,'nearest','crop');
%         
%         [imdb, count ] =  insertPatch(imdb,count,tempr , label);
%         
%         count = count + 1;
%         
%         templr =  fliplr(tempr);
%         %         imdb.images.data(:,count) = templr(:);
%         
%         [imdb, count ] =  insertPatch(imdb,count,templr,label);
%         
%         
%         
%         count = count + 1;
%         
%          templd =  flipud(tempr);
%         %         imdb.images.data(:,count) = templd(:);
%         
%         [imdb, count ] =  insertPatch(imdb,count,templd, label);
%         
%         
%         count = count + 1;
%         
%         % rotate the image by 270
%         tempr =  imrotate(temp,270,'nearest','crop');
%         
%         [imdb, count ] =  insertPatch(imdb,count,tempr , label);
%         
%         count = count + 1;
%         
%         templr =  fliplr(tempr);
%         %         imdb.images.data(:,count) = templr(:);
%         
%         [imdb, count ] =  insertPatch(imdb,count,templr,label);
%         
%             
%         count = count + 1;
%         
%          templd =  flipud(tempr);
%         %         imdb.images.data(:,count) = templd(:);
%         
%         [imdb, count ] =  insertPatch(imdb,count,templd, label);
%         
%         
%         count = count + 1;
%         
%         
    end
end
end

function [imdb, count] = insertPatch(imdb,count,image , label )

imdb.images.data(:,:, count) = image;
imdb.images.label(1,count) = label;
%         imdb.images.label(2,count) = 1 - label;
num = 5;
b = mod(count,num);
if( b == 0 )
    imdb.images.set(count) = 2;
else
    imdb.images.set(count) = 1;
end


end
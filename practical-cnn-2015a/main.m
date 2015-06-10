
imdb_train.meta = struct('classes',[],'set',[]);
imdb_train.images = struct('data',[],'label',[],'set',[]);
% fieldnames(imdb.meta);
% fieldnames(imdb.images);
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Leber';
fnames = dir(path);
num_data = 33121;
dimx = 100;
dimy = 100;
n = 50;
m = 24;

imdb_train.images.data = single(zeros(dimx,dimy, num_data));
% imdb.images.label = single(zeros(2, num_data));
imdb_train.images.label = single(zeros(1, num_data));
imdb_train.images.set = single(zeros(1, num_data));
imdb_train.meta.classes = {1,2};
imdb_train.meta.set = {1,2};
count = 1;
label = 1;
rotationAngle = 5;
MAX = 1000;

for K = 3:37
    fileName = fullfile(path,fnames(K).name);
   [imdb_train,count] = cnnextractPatch(fileName,dimx , dimy, imdb_train , count, label, MAX);
%    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
   
   
  % disp(count);
  
end
%     disp('count of 0' + count);

path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Tumor';
fnames = dir(path);

label = 2 ;
for K = 3:36
     fileName = fullfile(path,fnames(K).name);
   [imdb_train,count] = cnnextractPatch(fileName,dimx , dimy, imdb_train , count, label, MAX);
%    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
  
   
end


disp(count);
save('./data/mit_new_train.mat','-struct','imdb_train', '-v7.3');
disp('file saved');






% test data  preparation
% num_data = 2000;
% imdb_test.meta = struct('classes',[],'set',[]);
% imdb_test.images = struct('data',[],'label',[],'set',[]);
% imdb_test.images.data = single(zeros(dimx,dimy, num_data));
% % imdb.images.label = single(zeros(2, num_data));
% imdb_test.images.label = single(zeros(1, num_data));
% imdb_test.images.set = single(zeros(1, num_data));
% imdb_test.meta.classes = {1,2};
% imdb_test.meta.set = {1,2};
% 
% count = 1 ;
% 
% MAX = 1000;
% for K = 41:43
%     fileName = fullfile(path,fnames(K).name);
%    [imdb_test,count] = cnnextractPatch(fileName,dimx , dimy, imdb_test , count, label, MAX);
% %    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
%    
%    
%   % disp(count);
%   
% end
% %     disp('count of 0' + count);
% 
% path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Tumor';
% fnames = dir(path);
% 
% label = 2 ;
% for K = 35:36
%      fileName = fullfile(path,fnames(K).name);
%    [imdb_test,count] = cnnextractPatch(fileName,dimx , dimy, imdb_test , count, label, MAX);
% %    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
%   
%    
% end
% 
% 
% disp(count);
% save('./data/mit_new_test.mat','-struct','imdb_test', '-v7.3');
% disp('file saved');
% 


%figure;
%imshow(temp);




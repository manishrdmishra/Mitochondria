
imdb_train.meta = struct('classes',[],'set',[]);
imdb_train.images = struct('data',[],'label',[],'set',[]);
% fieldnames(imdb.meta);
% fieldnames(imdb.images);
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Leber';
fnames = dir(path);
num_data = 10000 ;
dimx = 300;
dimy = 300;
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

for K = 3:42
    fileName = fullfile(path,fnames(K).name);
   [imdb_train,count] = cnnextractPatch(fileName,dimx , dimy, imdb_train , count, label, MAX);
%    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
   
   
  % disp(count);
  
end
%     disp('count of 0' + count);

path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Tumor';
fnames = dir(path);

label = 2 ;
for K = 3:32
     fileName = fullfile(path,fnames(K).name);
   [imdb_train,count] = cnnextractPatch(fileName,dimx , dimy, imdb_train , count, label, MAX);
%    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
  
   
end


disp(count);
save('./data/mit_new_train.mat','-struct','imdb_train', '-v7.3');
disp('file saved');










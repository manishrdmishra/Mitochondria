%test data  preparation
num_data = 145;
dimx =  300;
dimy = 300;
imdb_test.meta = struct('classes',[],'set',[]);
imdb_test.images = struct('data',[],'label',[],'set',[]);
imdb_test.images.data = single(zeros(dimx,dimy, num_data));
% imdb.images.label = single(zeros(2, num_data));
imdb_test.images.label = single(zeros(1, num_data));
imdb_test.images.set = single(zeros(1, num_data));
imdb_test.meta.classes = {1,2};
imdb_test.meta.set = {1,2};

count = 1 ;

MAX = 1000;
label = 1;
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_Predict/Leber';
fnames = dir(path);

for K = 3:6
    fileName = fullfile(path,fnames(K).name);
   [imdb_test,count] = cnnextractPatch(fileName,dimx , dimy, imdb_test , count, label, MAX);
%    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
   
   
  % disp(count);
  
end
%     disp('count of 0' + count);

path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_Predict/Tumor';
fnames = dir(path);

label = 2 ;
for K = 3:6
     fileName = fullfile(path,fnames(K).name);
   [imdb_test,count] = cnnextractPatch(fileName,dimx , dimy, imdb_test , count, label, MAX);
%    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
  
   
end


disp(count);
save('./data/mit_new_test.mat','-struct','imdb_test', '-v7.3');
disp('file saved');



%figure;
%imshow(temp);

%test data  preparation
num_data = 4000;
dimx =  250;
dimy = 250;
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
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_Predict_HR/Leber';
%path ='/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_Predict_6';
fnames = dir(path);
n =  size(fnames);
for K = 3:n
    fileName = fullfile(path,fnames(K).name);
   [imdb_test,count] = cnnextractPatch(fileName,dimx , dimy, imdb_test , count, label, MAX);
%    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
   
   
  disp(count);
  
end
%     disp('count of 0' + count);

path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_Predict_HR/Tumor';
fnames = dir(path);

label = 2 ;
for K = 3:size(fnames)
     fileName = fullfile(path,fnames(K).name);
   [imdb_test,count] = cnnextractPatch(fileName,dimx , dimy, imdb_test , count, label, MAX);
%    augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
  
   
end


disp(count);
save('./data/mit_hr.mat','-struct','imdb_test', '-v7.3');
disp('file saved');



%figure;
%imshow(temp);

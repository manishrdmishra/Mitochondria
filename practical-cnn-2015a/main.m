
imdb.meta = struct('classes',[],'set',[]);
imdb.images = struct('data',[],'label',[],'set',[]);
fieldnames(imdb.meta);
fieldnames(imdb.images);
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Leber';
fnames = dir(path);
num_data = 50;
dimx = 200;
dimy = 200;
n = 50;
m = 24;

imdb.images.data = single(zeros(dimx,dimy, num_data));
imdb.images.label = single(zeros(1, num_data));
imdb.images.set = single(zeros(1, num_data));
imdb.meta.classes = {0,1};
imdb.meta.set = {1,2};
count = 1;
label = 1;
rotationAngle = 3;
for K = 3:n
    fileName = fullfile(path,fnames(K).name);
   [imdb,count] = augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
  % disp(count);
  
end

%    disp('count of 0' + count);

path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Tumor';
fnames = dir(path);


for K = 3:m
     fileName = fullfile(path,fnames(K).name);
   [imdb,count] = augmentImages(fileName,rotationAngle , imdb , count, label,num_data);
end
disp(count);
save('./data/smallmit.mat','-struct','imdb', '-v7.3');
disp('file saved');
%figure;
%imshow(temp);




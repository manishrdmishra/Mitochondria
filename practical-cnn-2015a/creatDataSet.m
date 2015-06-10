dimx = 70;
dimy = 70;
num_data = 71569;
imdb.images = struct('data',[],'label',[]);
imdb.images.data = single(zeros(dimx*dimy, num_data));
imdb.images.label = single(zeros(2, num_data));

path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Leber';
fnames = dir(path);
count = 1;
n = 40;
label = 0;
for K = 3:20
    fileName = fullfile(path,fnames(K).name);
     [imdb,count] = extractPatch(fileName,dimx,dimy, imdb , count, label,num_data);
end
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Tumor';
fnames = dir(path);

label = 1;
m = 35;
for K = 3:15
     fileName = fullfile(path,fnames(K).name);
      [imdb,count] = extractPatch(fileName,dimx,dimy, imdb , count, label,num_data);
end


path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Leber';
fnames = dir(path);
label = 0;
for K = 21:n
    fileName = fullfile(path,fnames(K).name);
     [imdb,count] = extractPatch(fileName,dimx,dimy, imdb , count, label,num_data);
end



path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TEST/Tumor';
fnames = dir(path);

label = 1;

for K = 16:m
     fileName = fullfile(path,fnames(K).name);
      [imdb,count] = extractPatch(fileName,dimx,dimy, imdb , count, label,num_data);
end
save('./data/neural_net.mat','-struct','imdb', '-v7.3');
disp('file saved');
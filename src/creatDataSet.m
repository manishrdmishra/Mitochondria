dimx = 150; % patch size
dimy = 150; % patch size y
num_data = 12865 %20641 for 100; % number of patches % 
imdb.images = struct('data',[],'label',[]);
imdb.images.data = single(zeros(dimx*dimy, num_data));
imdb.images.label = single(zeros(2, num_data));


%path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_TEST_Cal/Leber/low resolution';
path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_TEST_Cal/Leber/high resolution';
fnames = dir(path); %lists the files and folders in the current folder.
count = 1;
n = 53;
label = 0;
for K = 4:20
    fileName = fullfile(path,fnames(K).name); %returns a string containing the full path to  file.
     [imdb,count] = extractPatch(fileName,dimx,dimy, imdb , count, label,num_data);
end

%path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_TEST_Cal/Tumor/Low resolution';
path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_TEST_Cal/Tumor/High resolution';
fnames = dir(path);

label = 1;
m = 20;
for K = 4:10
     fileName = fullfile(path,fnames(K).name);
      [imdb,count] = extractPatch(fileName,dimx,dimy, imdb , count, label,num_data);
end


%path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_TEST_Cal/Leber/low resolution';
path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_TEST_Cal/Leber/high resolution';
fnames = dir(path);
label = 0;
for K = 21:n
    fileName = fullfile(path,fnames(K).name);
     [imdb,count] = extractPatch(fileName,dimx,dimy, imdb , count, label,num_data);
end



%path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_TEST_Cal/Tumor/Low resolution';
path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_TEST_Cal/Tumor/High resolution';
fnames = dir(path);

label = 1;

for K = 11:m
     fileName = fullfile(path,fnames(K).name);
      [imdb,count] = extractPatch(fileName,dimx,dimy, imdb , count, label,num_data);
end
save('./data/neural_net_high_150.mat','-struct','imdb', '-v7.3');
disp('file saved');
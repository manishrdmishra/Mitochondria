dimx = 70; % patch size
dimy = 70; % patch size y
num_data = 71569; % number of patches
validation.images = struct('data',[],'label',[]);
validation.images.data = single(zeros(dimx*dimy, num_data));
validation.images.label = single(zeros(2, num_data));


path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_Validation/Leber';
fnames = dir(path); %lists the files and folders in the current folder.
count = 1;
label = 0;
for K = 4:9
    fileName = fullfile(path,fnames(K).name); %returns a string containing the full path to  file.
     [validation,count] = extractPatch(fileName,dimx,dimy, validation , count, label,num_data);
end

path='/Users/Eden/Desktop/BMC (TUM)/Second sem/Machine learning/Project/Mitochondria/EM_Validation/Tumor';
fnames = dir(path);

label = 1;
for K = 4:6
     fileName = fullfile(path,fnames(K).name);
      [validation,count] = extractPatch(fileName,dimx,dimy, validation , count, label,num_data);
end

save('./data/validation_data.mat','-struct','validation', '-v7.3');
disp('file saved');
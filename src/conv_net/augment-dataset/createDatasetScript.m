 %% Execute this script to create data set for training. 

 
 %% Path of the folder where both healthy and cancer  Mitochondria
 %% images are kept. 
%  imageFolderPath = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_TRAIN_HR';
% 
% [ imdb_train  ] = createTrainDataset(imageFolderPath);

 imageFolderPath = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM_Predict_LR';
[ imdb_train  ] = createTestDataset(imageFolderPath);
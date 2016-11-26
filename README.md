# Mitochondria
The aim of this project was doing image level classification of Mithochondria images as healthy or cancerous. I used Convolutional neural network to do the classificaiton. I designed a ConvNet which was a variant of LeNet. 
The CNN was implemented in MatConvnet. Since we need lot of data to train a CNN from scratch, I extracted patches from images and each patch is further flipped and rotated to augment the data set for training.
We compared the results of CNN with classic machine learning approach in which features are extracted using Gabor filters and classified using SVM. 5 scales and 6 orientations was used to generate Gabor filters and the mean and the standard deviation of each filtered images are used as features.

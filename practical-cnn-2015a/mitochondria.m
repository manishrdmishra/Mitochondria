                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            function mitochondria(varargin)
% EXERCISE4   Part 4 of the VGG CNN practical
%ssetup('useGpu', true) ;
setup ;

% -------------------------------------------------------------------------
% Part 4.1: prepare the data
% -------------------------------------------------------------------------

% Load character dataset
% imdb = load('data/mit.mat') ;

% Visualize some of the data
% figure(10) ; clf ; colormap gray ;
% subplot(1,2,1) ;
% vl_imarraysc(imdb.images.data(:,:,imdb.images.label==1 & imdb.images.set==1)) ;
% axis image off ;
% title('training chars for ''a''') ;
%
% subplot(1,2,2) ;
% vl_imarraysc(imdb.images.data(:,:,imdb.images.label==1 & imdb.images.set==2)) ;
% axis image off ;
% title('validation chars for ''a''') ;

% -------------------------------------------------------------------------
% Part 4.2: initialize a CNN architecture
% -------------------------------------------------------------------------

net = initializeMitochondria() ;
vl_simplenn_display(net);
% -------------------------------------------------------------------------
% Part 4.3: train and evaluate the CNN
% -------------------------------------------------------------------------

trainOpts.batchSize = 50;
trainOpts.numEpochs = 10 ;
trainOpts.continue = true ;
trainOpts.errorType = 'binary';
trainOpts.useGpu = false ;
trainOpts.learningRate = 0.001 ;
trainOpts.expDir = 'data/experiment' ;
trainOpts = vl_argparse(trainOpts, varargin);

% Take the average image out
imdb = load('data/mit_23k.mat') ;

imageMean = mean(imdb.images.data(:)) ;
imdb.images.data = imdb.images.data - imageMean ;

% Convert to a GPU array if needed
if trainOpts.useGpu
    imdb.images.data = gpuArray(imdb.images.data) ;
end

% Call training function in MatConvNet
[net,info] = cnn_train(net, imdb, @getBatch, trainOpts) ;

% Move the CNN back to the CPU if it was trained on the GPU
if trainOpts.useGpu
    net = vl_simplenn_move(net, 'cpu') ;
end

% Save the result for later use
net.layers(end) = [] ;
net.imageMean = imageMean ;
save('data/experiment/cnnmit.mat', '-struct', 'net') ;

% -------------------------------------------------------------------------
% Part 4.4: visualize the learned filters
% -------------------------------------------------------------------------

figure(2) ; clf ; colormap gray ;
vl_imarraysc(squeeze(net.layers{1}.filters),'spacing',2)
axis equal ; title('filters in the first layer') ;

% figure(3) ; clf ; colormap gray ;
% vl_imarraysc(squeeze(net.layers{3}.filters),'spacing',2)
% axis equal ; title('filters in the third layer') ;

% -------------------------------------------------------------------------
% Part 4.5: apply the model
% -------------------------------------------------------------------------
%
%Load the CNN learned before
net = load('data/experiment/cnnmit.mat') ;
%im = imread('/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM/Tumor/Tumor_377-13/T37713_7_20000.tif');
%im = imread('/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM/Leber/Leber_380-13/L38013_7_20000.tif');
path = '/home/bug/git/Documents/third_sem/IDP/Mitochondria_Dataset/EM/Leber/Leber_379-13';
fnames = dir(path);

for K = 3:10
    f = fullfile(path,fnames(K).name);
     im = imread(f);
im = single(im(:,:,1));
im = imresize(im,[200,200]);
im = 256 * (im - net.imageMean) ;
res = vl_simplenn(net, im) ;
%  scores = squeeze(gather(res(end).x)) ;
[score,pred] = max(squeeze(res(end).x(1,:,:)));

end
% [bestScore, best] = max(scores) ;
% bestScore
% best
% figure(1) ; clf ; imagesc(im) ;
% title(sprintf('%s (%d), score %.3f',...
% net.classes.description{best}, best, bestScore)) ;
% %net = load('data/chars-experiment/charscnn-jit.mat') ;
%
% % Load the sentence
% im = im2single(imread('data/sentence-lato.png')) ;
% im = 256 * (im - net.imageMean) ;
%
% % Apply the CNN to the larger image
% res = vl_simplenn(net, im) ;
%
% % Visualize the results
% figure(3) ; clf ;
% decodeCharacters(net, imdb, im, res) ;

% % -------------------------------------------------------------------------
% % Part 4.6: train with jitter
% % -------------------------------------------------------------------------
%
% trainOpts.batchSize = 100 ;
% trainOpts.numEpochs = 15 ;
% trainOpts.continue = true ;
% trainOpts.learningRate = 0.001 ;
% trainOpts.expDir = 'data/chars-jit-experiment' ;
%
% % Initlialize a new network
% net = initializeCharacterCNN() ;
%
% % Call training function in MatConvNet
% [net,info] = cnn_train(net, imdb, @getBatchWithJitter, trainOpts) ;
%
% % Move the CNN back to CPU if it was trained on GPU
% if trainOpts.useGpu
%   net = vl_simplenn_move(net, 'cpu') ;
% end
%
% % Save the result for later use
% net.layers(end) = [] ;
% net.imageMean = imageMean ;
% save('data/chars-experiment/charscnn-jit.mat', '-struct', 'net') ;
%
% % Visualize the results on the sentence
% figure(4) ; clf ;
% decodeCharacters(net, imdb, im, vl_simplenn(net, im)) ;
%
% % --------------------------------------------------------------------
function [im, labels] = getBatch(imdb, batch)
% % --------------------------------------------------------------------

im = imdb.images.data(:,:,:,batch) ;
%im = 256 * reshape(im, 200, 200, 1, []) ;
labels = imdb.images.label(1,batch) ;

% % --------------------------------------------------------------------
function [im, labels] = getBatchWithJitter(imdb, batch)
% % --------------------------------------------------------------------
im = imdb.images.data(:,:,batch) ;
labels = imdb.images.label(1,batch) ;
if isempty(opts.train), opts.train = find(imdb.images.set==1) ; end

n = numel(batch) ;
train = find(imdb.images.set == 1) ;

sel = randperm(numel(train), n) ;
im1 = imdb.images.data(:,:,sel) ;

sel = randperm(numel(train), n) ;
im2 = imdb.images.data(:,:,sel) ;

ctx = [im1 im2] ;
ctx(:,17:48,:) = min(ctx(:,17:48,:), im) ;

dx = randi(11) - 6 ;
im = ctx(:,(17:48)+dx,:) ;
sx = (17:48) + dx ;

dy = randi(5) - 2 ;
sy = max(1, min(32, (1:32) + dy)) ;

im = ctx(sy,sx,:) ;

Visualize the batch:
figure(100) ; clf ;
vl_imarraysc(im) ;

im = 256 * reshape(im, 32, 32, 1, []) ;




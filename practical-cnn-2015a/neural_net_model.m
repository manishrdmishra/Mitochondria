%load the data
imdb = load('data/neural_net_70k_40L_35_T.mat') ;
imageMean = mean(imdb.images.data(:)) ;

%normalize the data
imdb.images.data = imdb.images.data - imageMean ;

inputs = (imdb.images.data);
targets = (imdb.images.label);

% Create a Pattern Recognition Network
hiddenLayerSize = [150 , 70];
net = patternnet(hiddenLayerSize);
% View the Network
view(net)
% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 60/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 20/100;


% Train the Network
[net,tr] = train(net,inputs,targets);

plotperform(tr)
% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)




% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotconfusion(targets,outputs)
% figure, ploterrhist(errors)

% testX = x(:,tr.testInd);
% testT = t(:,tr.testInd);
% 
% testY = net(testX);
% testClasses = testY > 0.5

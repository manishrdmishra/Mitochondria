% save the model after training (include the following line in
% neural_net_model)

%save('./data/NN_model.mat','net', '-v7.3');
NN_model = load('data/NN_model.mat') ;
validation = load('data/validation_data.mat') ;
imageMean = mean(validation.images.data(:)) ;

%normalize the data
validation.images.data = validation.images.data - imageMean ;
inputs = (validation.images.data);
targets = (validation.images.label);

% make predictions based on the model

outputs = NN_model.net(inputs);
perf = perform(NN_model.net,targets,outputs);
%classes = vec2ind(outputs);
plotconfusion(targets,outputs);
function [net, info] = train_model(augTrain, augValidation, numClasses)
% Fungsi untuk melakukan training model CNN
% Input:
%   - augTrain: augmentedImageDatastore untuk training
%   - augValidation: augmentedImageDatastore untuk validation
%   - numClasses: jumlah kelas pada dataset
% Output:
%   - net: model CNN yang sudah terlatih
%   - info: informasi proses training

    disp('Membuat model CNN...');

    % Arsitektur CNN Sederhana
    layers = [
        imageInputLayer([224 224 3], 'Name', 'input')

        convolution2dLayer(3, 16, 'Padding', 'same', 'Name', 'conv_1')
        batchNormalizationLayer('Name', 'bn_1')
        reluLayer('Name', 'relu_1')

        maxPooling2dLayer(2, 'Stride', 2, 'Name', 'maxpool_1')

        convolution2dLayer(3, 32, 'Padding', 'same', 'Name', 'conv_2')
        batchNormalizationLayer('Name', 'bn_2')
        reluLayer('Name', 'relu_2')

        maxPooling2dLayer(2, 'Stride', 2, 'Name', 'maxpool_2')

        fullyConnectedLayer(numClasses, 'Name', 'fc')
        softmaxLayer('Name', 'softmax')
        classificationLayer('Name', 'output')
    ];

    disp('Model CNN berhasil dibuat.');

    % Pengaturan Training
    options = trainingOptions('sgdm', ...
        'InitialLearnRate', 0.001, ...
        'MaxEpochs', 10, ...
        'ValidationData', augValidation, ...
        'ValidationFrequency', 30, ...
        'Verbose', false, ...
        'Plots', 'training-progress');

    disp('Training model dimulai...');
    % Training Model
    [net, info] = trainNetwork(augTrain, layers, options);
    disp('Training model selesai.');
end

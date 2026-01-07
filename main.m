%% Klasifikasi Sayuran Menggunakan MATLAB
% Main Script

clc;
clear;
close all;

disp('--- Klasifikasi Sayuran Dimulai ---');

%% 1. Load Dataset
disp('Memuat dataset...');
trainDataPath = fullfile('dataset', 'train');
testDataPath = fullfile('dataset', 'test');
valDataPath = fullfile('dataset', 'validation');

% Load data dengan imageDatastore
imdsTrain = imageDatastore(trainDataPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
imdsTest = imageDatastore(testDataPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
imdsValidation = imageDatastore(valDataPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

disp('Dataset berhasil dimuat.');

%% 2. Preprocessing Data
disp('Melakukan preprocessing data...');
imageSize = [224 224]; % Ubah sesuai kebutuhan Anda

% Resize images
augmentedTrain = augmentedImageDatastore(imageSize, imdsTrain);
augmentedTest = augmentedImageDatastore(imageSize, imdsTest);
augmentedValidation = augmentedImageDatastore(imageSize, imdsValidation);

disp('Preprocessing selesai.');

%% 3. Definisikan Model CNN Sederhana
disp('Membuat model CNN...');
layers = [
    imageInputLayer([224 224 3])

    convolution2dLayer(3, 16, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2, 'Stride', 2)

    convolution2dLayer(3, 32, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2, 'Stride', 2)

    fullyConnectedLayer(numel(unique(imdsTrain.Labels)))
    softmaxLayer
    classificationLayer
];

%% 4. Set Pengaturan Training
options = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.001, ...
    'MaxEpochs', 10, ...
    'ValidationData', augmentedValidation, ...
    'ValidationFrequency', 30, ...
    'Verbose', false, ...
    'Plots', 'training-progress');

%% 5. Training Model
disp('Training model...');
net = trainNetwork(augmentedTrain, layers, options);
disp('Training selesai.');

%% 6. Evaluasi Model
disp('Evaluasi model...');
YPred = classify(net, augmentedTest);
YTest = imdsTest.Labels;

accuracy = sum(YPred == YTest) / numel(YTest) * 100;
disp(['Akurasi Model: ', num2str(accuracy), '%']);

% Plot confusion matrix
figure;
plotconfusion(YTest, YPred);
title('Confusion Matrix');

%% 7. Simpan Model
disp('Menyimpan model...');
save('models/trainedModel.mat', 'net');
disp('Model berhasil disimpan di folder models.');

%% 8. Prediksi Satu Gambar (Opsional)
% img = imread('contoh_gambar.jpg');
% imgResized = imresize(img, imageSize);
% label = classify(net, imgResized);
% imshow(img);
% title(['Prediksi: ', char(label)]);

disp('--- Proses Selesai ---');

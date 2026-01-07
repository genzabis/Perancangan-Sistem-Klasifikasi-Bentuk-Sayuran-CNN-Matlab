function [augTrain, augValidation, augTest] = preprocess_data(imdsTrain, imdsValidation, imdsTest, imageSize)
% Fungsi untuk preprocessing dataset klasifikasi sayuran
% Input:
%   - imdsTrain: imageDatastore untuk data training
%   - imdsValidation: imageDatastore untuk data validation
%   - imdsTest: imageDatastore untuk data testing
%   - imageSize: ukuran gambar target (misalnya [224 224])
% Output:
%   - augTrain: augmentedImageDatastore untuk training
%   - augValidation: augmentedImageDatastore untuk validation
%   - augTest: augmentedImageDatastore untuk testing

    % Augmentasi untuk data training
    imageAugmenter = imageDataAugmenter( ...
        'RandRotation', [-10 10], ...
        'RandXTranslation', [-5 5], ...
        'RandYTranslation', [-5 5], ...
        'RandXScale', [0.9 1.1], ...
        'RandYScale', [0.9 1.1]);

    augTrain = augmentedImageDatastore(imageSize, imdsTrain, 'DataAugmentation', imageAugmenter);

    % Preprocessing untuk validation dan testing (hanya resize)
    augValidation = augmentedImageDatastore(imageSize, imdsValidation);
    augTest = augmentedImageDatastore(imageSize, imdsTest);

    disp('Preprocessing data selesai.');
end

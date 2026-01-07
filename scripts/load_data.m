function [imdsTrain, imdsValidation, imdsTest] = load_data(trainPath, valPath, testPath)
% Fungsi untuk memuat dataset klasifikasi sayuran
% Input:
%   - trainPath: path folder dataset training
%   - valPath: path folder dataset validation
%   - testPath: path folder dataset testing
% Output:
%   - imdsTrain: imageDatastore untuk data training
%   - imdsValidation: imageDatastore untuk data validation
%   - imdsTest: imageDatastore untuk data testing

    % Load dataset training
    imdsTrain = imageDatastore(trainPath, ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');

    % Load dataset validation
    imdsValidation = imageDatastore(valPath, ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');

    % Load dataset testing
    imdsTest = imageDatastore(testPath, ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');

    % Tampilkan ringkasan jumlah gambar pada masing-masing set
    disp('Ringkasan Dataset:');
    disp('--------------------------');
    disp(['Jumlah gambar Train      : ', num2str(numel(imdsTrain.Files))]);
    disp(['Jumlah gambar Validation : ', num2str(numel(imdsValidation.Files))]);
    disp(['Jumlah gambar Test       : ', num2str(numel(imdsTest.Files))]);
    disp('--------------------------');
end

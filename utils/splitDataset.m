function splitDataset(sourceFolder, targetFolder, trainRatio, valRatio, testRatio)
% Fungsi untuk membagi dataset menjadi train, validation, dan test
% Input:
%   - sourceFolder: folder asal dataset (berisi subfolder per label)
%   - targetFolder: folder tujuan dataset terpisah
%   - trainRatio: rasio data training (misal 0.7)
%   - valRatio: rasio data validation (misal 0.15)
%   - testRatio: rasio data testing (misal 0.15)

    categories = dir(sourceFolder);
    categories = categories([categories.isdir] & ~startsWith({categories.name}, '.'));

    for i = 1:length(categories)
        categoryName = categories(i).name;
        sourceCategoryPath = fullfile(sourceFolder, categoryName);

        % Buat folder tujuan per kategori
        trainFolder = fullfile(targetFolder, 'train', categoryName);
        valFolder = fullfile(targetFolder, 'validation', categoryName);
        testFolder = fullfile(targetFolder, 'test', categoryName);

        if ~exist(trainFolder, 'dir'); mkdir(trainFolder); end
        if ~exist(valFolder, 'dir'); mkdir(valFolder); end
        if ~exist(testFolder, 'dir'); mkdir(testFolder); end

        % Ambil semua gambar dalam folder kategori
        imageFiles = dir(fullfile(sourceCategoryPath, '*.*'));
        imageFiles = imageFiles(~[imageFiles.isdir]);

        % Randomisasi urutan file
        imageFiles = imageFiles(randperm(length(imageFiles)));

        % Hitung jumlah gambar per bagian
        totalImages = length(imageFiles);
        numTrain = round(trainRatio * totalImages);
        numVal = round(valRatio * totalImages);

        % Bagi dataset
        trainFiles = imageFiles(1:numTrain);
        valFiles = imageFiles(numTrain+1 : numTrain+numVal);
        testFiles = imageFiles(numTrain+numVal+1 : end);

        % Pindahkan file
        moveFiles(trainFiles, sourceCategoryPath, trainFolder);
        moveFiles(valFiles, sourceCategoryPath, valFolder);
        moveFiles(testFiles, sourceCategoryPath, testFolder);

        disp(['Kategori ', categoryName, ' berhasil dibagi.']);
    end

    disp('Pembagian dataset selesai.');
end

function moveFiles(files, sourcePath, targetPath)
% Fungsi pembantu untuk memindahkan file
    for i = 1:length(files)
        sourceFile = fullfile(sourcePath, files(i).name);
        targetFile = fullfile(targetPath, files(i).name);
        copyfile(sourceFile, targetFile);
    end
end

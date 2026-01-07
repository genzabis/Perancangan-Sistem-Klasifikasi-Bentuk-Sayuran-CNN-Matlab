function resizeImages(sourceFolder, targetFolder, imageSize)
% Fungsi untuk me-resize semua gambar dari sourceFolder ke targetFolder
% Input:
%   - sourceFolder: folder asal dataset
%   - targetFolder: folder tujuan dataset hasil resize
%   - imageSize: ukuran target gambar [tinggi lebar]

    % Baca semua subfolder (label)
    categories = dir(sourceFolder);
    categories = categories([categories.isdir] & ~startsWith({categories.name}, '.'));

    for i = 1:length(categories)
        categoryName = categories(i).name;
        sourceCategoryPath = fullfile(sourceFolder, categoryName);
        targetCategoryPath = fullfile(targetFolder, categoryName);

        % Buat folder tujuan jika belum ada
        if ~exist(targetCategoryPath, 'dir')
            mkdir(targetCategoryPath);
        end

        % Ambil semua gambar dalam folder kategori
        imageFiles = dir(fullfile(sourceCategoryPath, '*.*'));
        imageFiles = imageFiles(~[imageFiles.isdir]); % Exclude folder

        for j = 1:length(imageFiles)
            imageName = imageFiles(j).name;
            [~, ~, ext] = fileparts(imageName);
            if ismember(lower(ext), {'.jpg', '.jpeg', '.png', '.bmp'})
                % Baca dan resize gambar
                img = imread(fullfile(sourceCategoryPath, imageName));
                img = imresize(img, imageSize);

                % Simpan gambar ke folder tujuan
                imwrite(img, fullfile(targetCategoryPath, imageName));
            end
        end

        disp(['Folder ', categoryName, ' berhasil di-resize.']);
    end

    disp('Proses resize gambar selesai.');
end

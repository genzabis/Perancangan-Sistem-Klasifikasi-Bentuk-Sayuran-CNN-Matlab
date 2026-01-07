%% helperFunctions.m
% File ini berisi kumpulan fungsi pendukung untuk klasifikasi gambar

%% Fungsi: showDatasetInfo
function showDatasetInfo(imds)
% Menampilkan informasi jumlah gambar per kelas
    tbl = countEachLabel(imds);
    disp('Jumlah gambar per kelas:');
    disp(tbl);

    figure;
    bar(tbl.Count);
    title('Distribusi Data per Kelas');
    xlabel('Kelas');
    ylabel('Jumlah Gambar');
    xticklabels(tbl.Label);
    xtickangle(45);
end

%% Fungsi: calculateAccuracy
function acc = calculateAccuracy(predictedLabels, trueLabels)
% Menghitung akurasi manual (%)
    correct = sum(predictedLabels == trueLabels);
    total = numel(trueLabels);
    acc = (correct / total) * 100;
    disp(['Akurasi: ', num2str(acc), '%']);
end

%% Fungsi: showSampleImages
function showSampleImages(imds, numImages)
% Menampilkan contoh gambar secara acak
    if nargin < 2
        numImages = 9; % Default 9 gambar
    end

    perm = randperm(numel(imds.Files), numImages);
    figure;

    for i = 1:numImages
        subplot(ceil(sqrt(numImages)), ceil(sqrt(numImages)), i);
        img = readimage(imds, perm(i));
        imshow(img);
        title(char(imds.Labels(perm(i))));
    end
end

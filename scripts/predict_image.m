function predictedLabel = predict_image(net, imagePath, imageSize)
% Fungsi untuk memprediksi kelas dari sebuah gambar
% Input:
%   - net: model CNN yang sudah terlatih
%   - imagePath: path gambar yang akan diprediksi
%   - imageSize: ukuran input model CNN (misalnya [224 224])
% Output:
%   - predictedLabel: label hasil prediksi

    % Cek file gambar
    if ~isfile(imagePath)
        error('File gambar tidak ditemukan.');
    end

    % Baca dan resize gambar
    img = imread(imagePath);
    img = imresize(img, imageSize);

    % Tampilkan gambar
    figure;
    imshow(img);
    title('Gambar yang Diprediksi');

    % Prediksi gambar
    predictedLabel = classify(net, img);

    % Tampilkan hasil
    disp(['Hasil Prediksi: ', char(predictedLabel)]);
    title(['Hasil Prediksi: ', char(predictedLabel)]);
end

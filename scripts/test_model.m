function accuracy = test_model(net, augTest)
% Fungsi untuk menguji akurasi model CNN
% Input:
%   - net: model CNN yang sudah terlatih
%   - augTest: augmentedImageDatastore untuk testing
% Output:
%   - accuracy: akurasi model pada data testing

    disp('Melakukan pengujian model...');

    % Prediksi dataset testing
    predictedLabels = classify(net, augTest);

    % Label asli
    trueLabels = augTest.UnderlyingDatastores{1,1}.Labels;

    % Hitung akurasi
    accuracy = sum(predictedLabels == trueLabels) / numel(trueLabels) * 100;

    % Tampilkan hasil
    disp(['Akurasi model pada data testing: ', num2str(accuracy), '%']);

    % Tampilkan confusion matrix
    figure;
    confusionchart(trueLabels, predictedLabels);
    title(['Confusion Matrix (Akurasi: ', num2str(accuracy), '%)']);

    disp('Pengujian model selesai.');
end

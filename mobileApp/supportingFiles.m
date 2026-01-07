%% Supporting Functions for Vegetable Classification App

% Fungsi untuk validasi file gambar
function isValid = validateImageFile(filename)
    [~, ~, ext] = fileparts(filename);
    validExtensions = {'.jpg', '.jpeg', '.png', '.bmp'};
    isValid = any(strcmpi(ext, validExtensions));
end

% Fungsi untuk membaca dan resize gambar
function img = loadImage(filename, targetSize)
    img = imread(filename);
    img = imresize(img, targetSize);
end

% Fungsi untuk menampilkan pesan alert
function showAlert(app, message, title)
    uialert(app.UIFigure, message, title);
end

% Fungsi untuk memformat label prediksi agar lebih rapi
function formattedLabel = formatLabel(label)
    formattedLabel = strrep(char(label), '_', ' ');
end

clear;
original = imread('C:\Users\Manuel\Documents\MATLAB\images\artificiales\mitad_mitad_250x250.png');
%[m, n] = size(original);
%image_array = zeros(m, n, 'single');
image_dimensions = size(original);
image_array = zeros(image_dimensions, 'single');
image_array(:,:) = single(original);
flat_array = image_array(:);
flat_array = normalize_array(flat_array);
[center, U, obj_fcn] = fcm_from_image_array(flat_array, 2, [2, 100, 1e-5,1]);
figure;
to_plot = reshape(U(1, :), image_dimensions);
imagesc(to_plot), colorbar;
truesize;
figure;
to_plot = reshape(U(2, :), image_dimensions);
imagesc(to_plot), colorbar;
truesize;
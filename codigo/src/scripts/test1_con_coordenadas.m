clear;
original = imread('C:\Users\Manuel\Documents\MATLAB\images\artificiales\circulo_25x25.png');
[m, n] = size(original);
image_array = zeros(m, n, 'single');
image_array(:,:) = single(original);
flat_array = image_array(:);
[X,Y] = meshgrid(1:size(image_array,1), 1:size(image_array,2));
flat_array(:,2) = Y(:);
flat_array(:,3) = X(:);    
flat_array = normalize_array(flat_array);
[center, U, obj_fcn] = fcm_from_image_array(flat_array, 2, [2.0, 200, 1e-5,1]);
figure;
to_plot = reshape(U(1, :), n, m);
imagesc(to_plot);
truesize;
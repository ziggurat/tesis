function [ image_array ] = cell_image_to_2d_array( cells_of_images )
%CELL_IMAGE_TO_2D_ARRAY Summary of this function goes here
%   Detailed explanation goes here
    [m, n] = size(cells_of_images);
    image_array = zeros(m, n, 'single');
    image_array(:,:) = single(cells_of_images{1});
end


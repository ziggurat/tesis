function [ images_array ] = cell_image_to_3d_array( cells_of_images )
%CELL_IMAGE_TO_ARRAY Get a cell of images (obtained by a read) and returns
%an array.
%   Detailed explanation goes here
    [~, slices] = size(cells_of_images);
    [m, n] = size(cells_of_images{1});
    images_array = zeros(m, n, slices,'single');
    for cnt = 1 : slices
        images_array(:,:,cnt) = single(cells_of_images{cnt});
    end    
end


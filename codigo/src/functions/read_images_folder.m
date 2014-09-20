function [ cells_of_images ] = read_images_folder( folder )
%READ_IMAGES_FOLDER Converts a folder of png images to a cell of images
%   Detailed explanation goes here
    imagelist = dir(fullfile(folder,'*.png'));
    cells_of_images = cell(1, numel(imagelist));
    %first_image = imread(fullfile(folder,dicomlist(1).name));    
    %[m, n] = size(first_image);
    %images_array = zeros(m, n, numel(imagelist));    
    for cnt = 1 : numel(imagelist)
        cells_of_images{cnt} = imread(fullfile(folder,imagelist(cnt).name));  
    end
end


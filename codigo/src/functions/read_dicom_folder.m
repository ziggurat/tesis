function [ cells_of_images ] = read_dicom_folder( folder )
%READ_DICOM_FOLDER Reads all dicoms files from a folder assuming are slices
%of the same series. Returns an array of [image_with, image_height, images_slices]
%   Detailed explanation goes here
    dicomlist = dir(fullfile(folder,'*.dcm'));    
    cells_of_images = cell(1, numel(dicomlist));
    %first_image = dicomread(fullfile(folder,dicomlist(1).name));    
    %[m, n] = size(first_image);
    %images_array = zeros(m, n, numel(dicomlist));    
    for cnt = 1 : numel(dicomlist)
        cells_of_images{cnt} = dicomread(fullfile(folder,dicomlist(cnt).name));  
    end
end


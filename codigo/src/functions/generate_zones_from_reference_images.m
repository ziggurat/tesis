function [ cells_array ] = generate_zones_from_reference_images( image_array )
%GENERATE_ZONES_FROM_REFERENCE_IMAGES Summary of this function goes here
%   Detailed explanation goes here    
    values = unique(image_array);
    cells_array = cell(1, length(values));
    for i = 1 : length(values)
        image_array_copy = image_array;
        image_array_copy(image_array_copy == values(i)) = 1;
        image_array_copy(image_array_copy ~= 1) = 0;
        cells_array{i} = image_array_copy;
    end
    
end


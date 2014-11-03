function [ clean_image ] = removeNoiseAndFillHoles( image )
    filled_holes = imfill(image, 'holes');    
    clean_image = bwareaopen(filled_holes, 10);
end


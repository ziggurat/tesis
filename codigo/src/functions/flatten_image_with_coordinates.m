function [ flat ] = flatten_image_with_coordinates( image_array )
%FLATTEN_IMAGE_WITH_COORDINATES Summary of this function goes here
%   Detailed explanation goes here
    flat = image_array(:);
    [X,Y,Z] = meshgrid(1:size(image_array,1), 1:size(image_array,2),1:size(image_array,3));
    flat(:,2) = Y(:);
    flat(:,3) = X(:);
    flat(:,4) = Z(:);
end


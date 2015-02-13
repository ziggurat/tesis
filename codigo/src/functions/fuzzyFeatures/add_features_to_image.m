function [ image_with_features ] = add_features_to_image( image, features)
%ADD_FEATURES_TO_IMAGE Summary of this function goes here
%   Detailed explanation goes here
    image_with_features = zeros(numel(image), numel(features) + 1);
    image_with_features(:,1) = image(:);
    features_count = numel(features);
    for i = 1 : features_count
        image_with_features(:,i+1) = features{i}(:);
    end    
end


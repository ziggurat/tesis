function [ output_args ] = flatten_image_with_features_for_fuzzy( image_array, features )
%FLATTEN_IMAGE_WITH_FEATURES_FOR_FUZZY Summary of this function goes here
%   Detailed explanation goes here

    flat = image_array(:);
    % Recorrer la lista de features, aplanarlas y agregarlas a una columna
    % de flat.
    flat(:,2) = feature_plana_1(:);
end


function [ regiones ] = umbralarGroundTruth( GroundTruthImage )
%UMBRALARGROUNDTRUTH Summary of this function goes here
%   Detailed explanation goes here
    intensidades = unique(GroundTruthImage);
    regiones = cell(1, numel(intensidades));
    for i = 1 : numel(intensidades)
        regiones{i} = zeros(size(GroundTruthImage));
        regiones{i}(GroundTruthImage == intensidades(i)) = 1;
    end
end


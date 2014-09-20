function [ cell_of_clusters_images ] = split_images( cell_of_prob_matrices )
%SPLIT_IMAGES Genera un cell de imagenes binarias desde un cell de matrices
%de probabilidades.
%   Detailed explanation goes here
    [~, clusters_qty] = size(cell_of_prob_matrices);
    max_dimension = max(size(cell_of_prob_matrices));
    dimension_to_merge = max_dimension + 1;
    merged_matrix = cat(dimension_to_merge, cell_of_prob_matrices{:});
    [~, index] = max(merged_matrix,[],dimension_to_merge);
    cell_of_clusters_images = cell(1, clusters_qty);
    for cnt = 1 : clusters_qty        
        AUX = ones(size(cell_of_prob_matrices{cnt}));
        AUX(index~=cnt) = 0;
        cell_of_clusters_images{cnt} = AUX;
    end    
end


function [ output_args ] = show_clusters_figures(  U, slice, original_image_cells )
%SHOW_CLUSTERS_FIGURES Summary of this function goes here
%   Detailed explanation goes here
    [~, slices] = size(original_image_cells);
    [n, m] = size(original_image_cells{1});
    [clusters, ~] = size(U);
    cell_of_clusters = cell(clusters);              
    for cnt = 1 : clusters
        figure;
        cell_of_clusters{cnt} = reshape(U(cnt,:), n, m, slices);
        imagesc(cell_of_clusters{cnt}(:,:,slice));
        truesize;
    end    
end


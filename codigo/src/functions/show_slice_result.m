function [ cell_of_clusters ] = show_slice_result( U, slice, original_image_cells )
%SHOW_SLICE_RESULT Summary of this function goes here
%   Detailed explanation goes here    
    [~, slices] = size(original_image_cells);
    [n, m] = size(original_image_cells{1});
    [clusters, ~] = size(U);
    cell_of_clusters = cell(clusters);
    cols = ceil((clusters + 1)/2);
    figure;
    hold on;
    suptitle(strcat('Slice ', int2str(slice)));
    % Draw original image
    subplot(2,cols,1);
    subimage(original_image_cells{slice});    
    for cnt = 1 : clusters
        cell_of_clusters{cnt} = reshape(U(cnt,:), n, m, slices);
        subplot(2,cols,cnt+1);
        imagesc(cell_of_clusters{cnt}(:,:,slice));
    end
    truesize;   
end


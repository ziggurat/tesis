function [ points ] = createRayGrid( from, to, zindex, step)
%CREATERAYGRID Creates a square grid of points
    [X, Y] = meshgrid(from:step:to,from:step:to);
    Z = cat(3, X, Y);
    Z2 = permute(Z, [3 1 2]);
    Z2 = Z2(:);
    points = reshape(Z2, 2, size(X,1)*size(X,2))';
    points(:,3) = zindex;
end


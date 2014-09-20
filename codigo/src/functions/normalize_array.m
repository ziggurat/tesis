function [ features ] = normalize_array( features )
%NORMALIZE_ARRAY Summary of this function goes here
%   Detailed explanation goes here
% Feature scaling using 0-mean normalization
    mu = mean(features);
    stds = std(features);
    stds(stds==0) = 1;
    features = bsxfun(@minus, features, mu);
    features = bsxfun(@rdivide, features, stds);    
end


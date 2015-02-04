function [ rounded_number ] = roundToDecimals( number, decimals )
%ROUNDTODECIMALS Summary of this function goes here
%   Detailed explanation goes here
    mult = 10^decimals;
    int_aux = ceil(number*mult);
    rounded_number = int_aux / mult;
end


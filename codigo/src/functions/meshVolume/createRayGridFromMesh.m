function [ points ] = createRayGridFromMesh( vertices1, vertices2 )
%CREATERAYGRIDFROMMESH Summary of this function goes here
%   Detailed explanation goes here
    
    joinVertices = cat(1, vertices1, vertices2);
    minVec = min(joinVertices);
    maxVec = max(joinVertices);
    distVec = maxVec - minVec;
    directionVec = distVec;
    directionVec(directionVec ~= max(directionVec)) = 0;
    directionVec(directionVec == max(directionVec)) = 1;
    
    
end


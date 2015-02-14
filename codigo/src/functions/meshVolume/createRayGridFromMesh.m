function [ points ] = createRayGridFromMesh( vertices1, vertices2, step )
%CREATERAYGRIDFROMMESH Summary of this function goes here
%   Detailed explanation goes here
    
    joinVertices = cat(1, vertices1, vertices2);    

    minVec = min(joinVertices);
    maxVec = max(joinVertices);   
    distVec = maxVec - minVec;

    maxIndex = find(distVec == max(distVec));
    maxIndex = maxIndex(1);
    directionVec = zeros(3,1);
    directionVec(maxIndex) = 1;
    
    from_to_indices = find(directionVec == 0);
    from_to_values = zeros(2);
    for i = 1 : 2
        from_to_values(i,1) = minVec(from_to_indices(i));
        from_to_values(i,2) = maxVec(from_to_indices(i));        
    end
	
    [X, Y] = meshgrid(from_to_values(1,1):step:from_to_values(1,2),from_to_values(2,1):step:from_to_values(2,2));
    Z = cat(3, X, Y);
    Z2 = permute(Z, [3 1 2]);
    Z2 = Z2(:);
    points = reshape(Z2, 2, size(X,1)*size(X,2))';
    
    points(:,3) = minVec(maxIndex);
    if (maxIndex == 1)
        points(:,[2 3]) = points(:, [3,2]);
        points(:,[1 2]) = points(:, [2,1]);
    end
    if (maxIndex == 2)
        points(:,[2 3]) = points(:, [3,2]);
    end
    
    
end


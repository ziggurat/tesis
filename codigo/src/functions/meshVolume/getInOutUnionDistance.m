function [ distance ] = getInOutUnionDistance( distances1, distances2 )
%GETINOUTVALUES Summary of this function goes here
%   Detailed explanation goes here
    if (~isempty(distances1) && ~isempty(distances2))
        BIN1 = zeros(numel(distances1),1);
        BIN1(1:2:end) = 1;

        BIN2 = zeros(numel(distances2),1);
        BIN2(1:2:end) = 1;

        dis1 = cat(2, distances1, BIN1);
        dis2 = cat(2, distances2, BIN2);
    
    
        allDistances = cat(1, dis1, dis2);    
        allDistances = sortrows(allDistances);        

        BIN3 = zeros(numel(allDistances(:,1)), 1);
        BIN3(1:2:end) = 1;

        allDistances(:,2) = allDistances(:,2) - BIN3;
        selectedDistances = allDistances(allDistances(:,2) == 0, 1);                
    else
        if (isempty(distances2))
            selectedDistances = distances1;
        else
            selectedDistances = distances2;
        end        
    end    
    inPairs = reshape(selectedDistances, 2, numel(selectedDistances) / 2);
    distance = sum(inPairs(2,:) - inPairs(1,:));
end


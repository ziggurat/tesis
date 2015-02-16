function [ quality_indicator, diff_volume, union_volume ] = meshVolumeQualityInd( p0, v0, nodes, faces, nodes2, faces2, gapSize )
    display('Start volume diff calculation');
    tic;    
    len=size(p0,1);
    volume_array = zeros(len, 1);
    union_volume_array= zeros(len, 1);
    parfor i=1:len       
       uniqueDistances = customRaySurf(p0(i,:), v0, nodes, faces, gapSize);       
       uniqueDistances2 = customRaySurf(p0(i,:), v0, nodes2, faces2, gapSize);       
       if isempty(uniqueDistances)
           if isempty(uniqueDistances2)
               continue; 
           end
       end
       allDistances = sort(cat(1, uniqueDistances, uniqueDistances2));       
       inPairs = reshape(allDistances, 2, numel(allDistances) / 2);
       volume_array(i) = sum(inPairs(2,:) - inPairs(1,:));
       union_volume_array(i) = getInOutUnionDistance(uniqueDistances, uniqueDistances2);
    end
    diff_volume = sum(volume_array) * gapSize^2;
    union_volume = sum(union_volume_array) * gapSize^2;
    quality_indicator = 1 - (diff_volume / union_volume);
    toc;
    display(strcat('Diff volume is: ', num2str(diff_volume)));
    display(strcat('Union volume is: ', num2str(union_volume)));
    display(strcat('Volume metric is: ', num2str(quality_indicator)));
    display('Finished volume diff calculation');
end


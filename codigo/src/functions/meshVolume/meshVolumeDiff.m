function [ volume ] = meshVolumeDiff( p0, v0, nodes, faces, nodes2, faces2, gapSize )
    display('Start volume diff calculation');
    tic;    
    len=size(p0,1);
    volume_array = zeros(len, 1);
    for i=1:len       
       uniqueDistances = customRaySurf(p0(i,:), v0, nodes, faces, gapSize);       
       uniqueDistances2 = customRaySurf(p0(i,:), v0, nodes2, faces2, gapSize);       
       if isempty(uniqueDistances)
           if isempty(uniqueDistances2)
               continue; 
           end
       end
       allDistances = sort(cat(1, uniqueDistances, uniqueDistances2));
       if max(size(allDistances)) == 2
           volume_array(i) = allDistances(2) - allDistances(1);
       else
           inPairs = reshape(allDistances, 2, size(allDistances,1) / 2);
           volume_array(i) = sum(inPairs(2,:) - inPairs(1,:));
       end
    end
    volume = sum(volume_array) * gapSize^2;
    toc;
    display('Finished volume diff calculation');    
end


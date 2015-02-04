function [ volume ] = meshVolumeDiff( p0, v0, nodes, faces, nodes2, faces2, gapSize )
    volume = 0;
    len=size(p0,1);    
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
           volume = volume + allDistances(2) - allDistances(1);
       else
           inPairs = reshape(allDistances, size(allDistances,1) / 2, 2);
           volume = volume + sum(inPairs(2,:) - inPairs(1,:));
       end
    end
    volume = volume * gapSize^2;
end


function [ distances ] = customRaySurf( p0, v0, nodes, faces, gapOffset)
    results = cell(1,3);
    p = [p0;p0;p0];    
    moda = zeros(1,3);
    p(1,v0==0) = p0(v0==0) + gapOffset * 0.25;
    p(2,v0==0) = p0(v0==0) + gapOffset * -0.25;
    %p(3,v0==0) = p0(v0==0);
    parfor i=1:3
        [ti,~,~,id]=raytrace(p(i,:),v0,nodes,faces);
        if isempty(id) continue; end
        results{i} = ti(id);
        moda(i) = max(size(ti(id)));
    end    
    cellIndices = find(moda==mode(moda));
    if isempty(cellIndices) 
        distances = [];
        return;
    end
    cellIndex = cellIndices(1);
    if cellIndex == 0
        distances = [];
    else
        distances = results{cellIndex};
    end
    if (mod(max(size(distances)),2) ~= 0)
        distances = [];
    end
end
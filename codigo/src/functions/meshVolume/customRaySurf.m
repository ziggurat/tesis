function [ distances ] = customRaySurf( p0, v0, nodes, faces, gapOffset)
    results = cell(1,6);
    p = [p0;p0;p0];
    moda = zeros(1,3);
    p(1,1:2) = p0(1:2) + gapOffset * -0.25;
    p(2,1:2) = p0(1:2) + gapOffset * 0.25;
    p(3,1:2) = p0(1:2) + gapOffset;    
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
end
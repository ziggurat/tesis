function new_vertices=trasladarEinvertir(vertices, offset)
    new_vertices = zeros(size(vertices));
    new_vertices(:,1) = (vertices(:,1) *  offset(2)) * -1;
    new_vertices(:,2) = (vertices(:,2) *  offset(3)) * -1;
    new_vertices(:,3) = (vertices(:,3) *  offset(4));
end
clusters = 4;
nii = load_nii('c:/imagenes_3d/IBSR_nifti_stripped/IBSR_01/IBSR_01_segTRI_fill_ana.nii');

cluster = cell(1, clusters);
clean_volume = cell(1, clusters);
newnode = cell(1, clusters);
newface = cell(1, clusters);

for c = 1 : clusters
    cluster{c} = nii.img;
    cluster{c}(cluster{c} ~= c-1) = 255;
    cluster{c}(cluster{c} == c-1) = 1;
    cluster{c}(cluster{c} == 255) = 0;
    clean_volume{c} = fillholes3d(cluster{c},1);    
    
    [v,f,regions,holes]=v2s(clean_volume{c},0.01, 0.05, 'simplify');
    newnode{c} = v;
    newface{c} = f;
    clear regions;
    clear holes;
    newnode{c} = trasladarEinvertir(newnode{c}, nii.hdr.dime.pixdim);
    vertface2obj(newnode{c}, newface{c}, strcat('c:\Users\Manuel\gt_mesh', num2str(c), '.obj'));
end

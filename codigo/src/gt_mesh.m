%% Configure the folders for reading the images and to save the experiments

images_root_folder = '/home/manuel/Tesis/imagenes_3d/'; 
%images_root_fodler = 'c:/imagenes_3d';

experiment_dest_folder = '/home/manuel/Tesis/exp2/';
mkdir(strcat(experiment_dest_folder));

clusters = 4;
nii = load_nii(strcat(images_root_folder,'IBSR_nifti_stripped/IBSR_01/IBSR_01_segTRI_fill_ana.nii'));

cluster = cell(1, clusters);
clean_volume = cell(1, clusters);
gt_mesh_nodes = cell(1, clusters);
gt_mesh_faces = cell(1, clusters);

for c = 1 : clusters
    cluster{c} = nii.img;
    cluster{c}(cluster{c} ~= c-1) = 255;
    cluster{c}(cluster{c} == c-1) = 1;
    cluster{c}(cluster{c} == 255) = 0;
    clean_volume{c} = fillholes3d(cluster{c},1);    
    
    [v,f,regions,holes]=v2s(clean_volume{c},0.01, 0.1, 'simplify');
    [gt_mesh_nodes{c},gt_mesh_faces{c}]=meshcheckrepair(v,f);    
    clear regions;
    clear holes;
    gt_mesh_nodes_trans{c} = trasladarEinvertir(gt_mesh_nodes{c}, nii.hdr.dime.pixdim);
    vertface2obj(gt_mesh_nodes_trans{c}, gt_mesh_faces{c}, strcat(experiment_dest_folder, 'gt_mesh', num2str(c), '.obj'));
end
clear cluster;
clear v;
clear f;
clear regions;
clear holes;
clear clean_volume;

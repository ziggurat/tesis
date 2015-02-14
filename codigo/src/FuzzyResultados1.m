clear all;
close all;

% Configure the folders for reading the images and to save the experiments %%

images_root_folder = '/home/cescuderol/Documents/tesis/tesis/'; 
%images_root_fodler = 'c:/imagenes_3d';

experiment_dest_folder = '/home/cescuderol/Documents/tesis/tesis/resultados_02_14/';
mkdir(strcat(experiment_dest_folder));

nii = load_nii(strcat(images_root_folder, 'IBSR_nifti_stripped/IBSR_01/IBSR_01_segTRI_fill_ana.nii'));


clusters = 4;

% -------------------------------------------------------------------------------
% Generate the GT mesh in gt_mesh_nodes and gt_mesh_faces
cluster = cell(1, clusters);
clean_volume = cell(1, clusters);
gt_mesh_nodes = cell(1, clusters);
gt_mesh_faces = cell(1, clusters);
gt_mesh_nodes_trans = cell(1, clusters);

for c = 1 : clusters
    cluster{c} = nii.img;
    cluster{c}(cluster{c} ~= c-1) = 255;
    cluster{c}(cluster{c} == c-1) = 1;
    cluster{c}(cluster{c} == 255) = 0;
    clean_volume{c} = fillholes3d(cluster{c},1);    
    
    [v,f,~,~]=v2s(clean_volume{c},0.01, 0.1, 'simplify');
    [gt_mesh_nodes{c},gt_mesh_faces{c}]=meshcheckrepair(v,f);
    gt_mesh_nodes_trans{c} = trasladarEinvertir(gt_mesh_nodes{c}, nii.hdr.dime.pixdim);
    vertface2obj(gt_mesh_nodes_trans{c}, gt_mesh_faces{c}, strcat(experiment_dest_folder, 'gt_mesh_', num2str(c), '.obj'));
end
clear clean_volume;

clear nii;
nii = load_nii(strcat(images_root_folder, 'IBSR_nifti_stripped/IBSR_01/IBSR_01_ana_strip.nii'));


% Run Fuzzy with intensities only
features = cell(1,0);

%features{1} = imgaussian(nii.img, 2);
%features{1} = gradient(double(nii.img));

[~, ~, ~, prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
[umbraladas, ~, ~] = split_images(prob_matrix_cell);
clean_volume = cell(1, clusters);
mesh_nodes_nofeatures = cell(1, clusters);
mesh_faces_nofeatures = cell(1, clusters);
mesh_nodes_nofeatures_trans = cell(1, clusters);
for i = 1 : clusters    
    clean_volume{i} = fillholes3d(umbraladas{i},1);    
        
    [v,f,~,~] = v2s(clean_volume{i},0.01, 0.1, 'simplify');
    [mesh_nodes_nofeatures{i},mesh_faces_nofeatures{i}]=meshcheckrepair(v,f);
    mesh_nodes_nofeatures_trans{c} = trasladarEinvertir(gt_mesh_nodes{c}, nii.hdr.dime.pixdim);
    vertface2obj(mesh_nodes_nofeatures_trans{c}, mesh_faces_nofeatures{c}, strcat(experiment_dest_folder, 'mesh_faces_nofeatures_', num2str(c), '.obj'));
end
clear clean_volume;
clear features;

% Run fuzzy with intensity + gaussian
features = cell(1,0);
features{1} = imgaussian(nii.img, 2);

[~, ~, ~, prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
[umbraladas, ~, ~] = split_images(prob_matrix_cell);
clean_volume = cell(1, clusters);
mesh_nodes_gaussian = cell(1, clusters);
mesh_faces_gaussian = cell(1, clusters);
mesh_nodes_gaussian_trans = cell(1, clusters);
for i = 1 : clusters    
    clean_volume{i} = fillholes3d(umbraladas{i},1);    
        
    [v,f,~,~] = v2s(clean_volume{i},0.01, 0.1, 'simplify');
    [mesh_nodes_gaussian{i},mesh_faces_gaussian{i}]=meshcheckrepair(v,f);
    mesh_nodes_gaussian_trans{c} = trasladarEinvertir(gt_mesh_nodes{c}, nii.hdr.dime.pixdim);
    vertface2obj(mesh_nodes_gaussian_trans{c}, mesh_faces_gaussian{c}, strcat(experiment_dest_folder, 'mesh_faces_gaussian_', num2str(c), '.obj'));
end
clear clean_volume;
clear features;

% Run fuzzy with intensity + gradient
features = cell(1,0);
features{1} = gradient(double(nii.img));

[~, ~, ~, prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
[umbraladas, ~, ~] = split_images(prob_matrix_cell);
clean_volume = cell(1, clusters);
mesh_nodes_gradient = cell(1, clusters);
mesh_faces_gradient = cell(1, clusters);
mesh_nodes_gradient_trans = cell(1, clusters);
for i = 1 : clusters    
    clean_volume{i} = fillholes3d(umbraladas{i},1);    
        
    [v,f,~,~] = v2s(clean_volume{i},0.01, 0.1, 'simplify');
    [mesh_nodes_gradient{i},mesh_faces_gradient{i}]=meshcheckrepair(v,f);
    mesh_nodes_gradient_trans{c} = trasladarEinvertir(gt_mesh_nodes{c}, nii.hdr.dime.pixdim);
    vertface2obj(mesh_nodes_gradient_trans{c}, mesh_faces_gaussian{c}, strcat(experiment_dest_folder, 'mesh_nodes_gradient_trans_', num2str(c), '.obj'));
end
clear clean_volume;
clear features;

% Run fuzzy with intensity + gaussian + gradient
features = cell(1,0);
features{1} = gradient(double(nii.img));
features{2} = imgaussian(nii.img, 2);

[~, ~, ~, prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
[umbraladas, ~, ~] = split_images(prob_matrix_cell);
clean_volume = cell(1, clusters);
mesh_nodes_gaussian_gradient = cell(1, clusters);
mesh_faces_gaussian_gradient = cell(1, clusters);
mesh_nodes_gaussian_gradient_trans = cell(1, clusters);
for i = 1 : clusters    
    clean_volume{i} = fillholes3d(umbraladas{i},1);    
        
    [v,f,~,~] = v2s(clean_volume{i},0.01, 0.1, 'simplify');
    [mesh_nodes_gaussian_gradient{i},mesh_faces_gaussian_gradient{i}]=meshcheckrepair(v,f);
    mesh_nodes_gaussian_gradient_trans{c} = trasladarEinvertir(gt_mesh_nodes{c}, nii.hdr.dime.pixdim);
    vertface2obj(mesh_nodes_gaussian_gradient_trans{c}, mesh_faces_gaussian{c}, strcat(experiment_dest_folder, 'mesh_nodes_gaussian_gradient_trans_', num2str(c), '.obj'));
end
clear clean_volume;
clear features;


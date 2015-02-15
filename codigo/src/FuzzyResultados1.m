clear all;
close all;

% Configure the folders for reading the images and to save the experiments %%

images_root_folder = '/home/cescuderol/Documents/tesis/tesis/'; 
%images_root_fodler = 'c:/imagenes_3d';

experiment_dest_folder = '/home/cescuderol/Documents/tesis/tesis/resultados_02_14/IBSR3/';
mkdir(strcat(experiment_dest_folder));

nii = load_nii(strcat(images_root_folder, 'IBSR_nifti_stripped/IBSR_03/IBSR_03_segTRI_fill_ana.nii'));


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
nii = load_nii(strcat(images_root_folder, 'IBSR_nifti_stripped/IBSR_03/IBSR_03_ana_strip.nii'));


% Run Fuzzy with intensities only
features = cell(1,0);

%features{1} = imgaussian(nii.img, 2);
%features{1} = gradient(double(nii.img));

[~, ~, ~, prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
[umbraladas, ~, ~] = split_images(prob_matrix_cell);
clean_volume = cell(1, clusters);
nofeatures.nodes = cell(1, clusters);
nofeatures.faces = cell(1, clusters);
nofeatures.trans_nodes = cell(1, clusters);
for i = 1 : clusters    
    clean_volume{i} = fillholes3d(umbraladas{i},1);    
        
    [v,f,~,~] = v2s(clean_volume{i},0.01, 0.1, 'simplify');
    [nofeatures.nodes{i},nofeatures.faces{i}]=meshcheckrepair(v,f);
    nofeatures.trans_nodes{i} = trasladarEinvertir(nofeatures.nodes{i}, nii.hdr.dime.pixdim);
    vertface2obj(nofeatures.trans_nodes{i}, nofeatures.faces{i}, strcat(experiment_dest_folder, 'nofeatures_', num2str(i), '.obj'));
end
clear clean_volume;
clear features;

% Run fuzzy with intensity + gaussian
features = cell(1,1);
features{1} = imgaussian(nii.img, 2);

[~, ~, ~, prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
[umbraladas, ~, ~] = split_images(prob_matrix_cell);
clean_volume = cell(1, clusters);
gaussian.nodes = cell(1, clusters);
gaussian.faces = cell(1, clusters);
gaussian.trans_nodes = cell(1, clusters);
for i = 1 : clusters    
    clean_volume{i} = fillholes3d(umbraladas{i},1);    
        
    [v,f,~,~] = v2s(clean_volume{i},0.01, 0.1, 'simplify');
    [gaussian.nodes{i},gaussian.faces{i}]=meshcheckrepair(v,f);
    gaussian.trans_nodes{i} = trasladarEinvertir(gaussian.nodes{i}, nii.hdr.dime.pixdim);
    vertface2obj(gaussian.trans_nodes{i}, gaussian.faces{i}, strcat(experiment_dest_folder, 'gaussian_', num2str(i), '.obj'));
end
clear clean_volume;
clear features;

% Run fuzzy with intensity + gradient
features = cell(1,1);
features{1} = gradient(double(nii.img));

[~, ~, ~, prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
[umbraladas, ~, ~] = split_images(prob_matrix_cell);
clean_volume = cell(1, clusters);
gradient.nodes = cell(1, clusters);
gradient.faces = cell(1, clusters);
gradient.trans_nodes = cell(1, clusters);
for i = 1 : clusters    
    clean_volume{i} = fillholes3d(umbraladas{i},1);    
        
    [v,f,~,~] = v2s(clean_volume{i},0.01, 0.1, 'simplify');
    [gradient.nodes{i},gradient.faces{i}]=meshcheckrepair(v,f);
    gradient.trans_nodes{i} = trasladarEinvertir(gradient.nodes{i}, nii.hdr.dime.pixdim);
    vertface2obj(gradient.trans_nodes{i}, gradient.faces{i}, strcat(experiment_dest_folder, 'gradient_', num2str(i), '.obj'));
end
clear clean_volume;
clear features;

% Run fuzzy with intensity + gaussian + gradient
features = cell(1,2);
features{1} = gradient(double(nii.img));
features{2} = imgaussian(nii.img, 2);

[~, ~, ~, prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
[umbraladas, ~, ~] = split_images(prob_matrix_cell);
clean_volume = cell(1, clusters);
gaussian_gradient.nodes = cell(1, clusters);
gaussian_gradient.faces = cell(1, clusters);
gaussian_gradient.trans_nodes = cell(1, clusters);
for i = 1 : clusters    
    clean_volume{i} = fillholes3d(umbraladas{i},1);    
        
    [v,f,~,~] = v2s(clean_volume{i},0.01, 0.1, 'simplify');
    [gaussian_gradient.nodes{i},gaussian_gradient.faces{i}]=meshcheckrepair(v,f);
    gaussian_gradient.trans_nodes{i} = trasladarEinvertir(gaussian_gradient.nodes{i}, nii.hdr.dime.pixdim);
    vertface2obj(gaussian_gradient.trans_nodes{i}, gaussian_gradient.faces{i}, strcat(experiment_dest_folder, 'gaussian_gradient_', num2str(i), '.obj'));
end
clear clean_volume;
clear features;

save(strcat(experiment_dest_folder, 'mallas_03.mat'));

clear all;
close all;

% Configure the folders for reading the images and to save the experiments %%

images_root_folder = '/home/manuel/Tesis/imagenes_3d/'; 
%images_root_fodler = 'c:/imagenes_3d';

experiment_dest_folder = '/home/manuel/Tesis/masTeValeQueAndes/';
mkdir(strcat(experiment_dest_folder));

nii = load_nii(strcat(images_root_folder, 'IBSR_nifti_stripped/IBSR_01/IBSR_01_ana_strip.nii'));


clusters = 4;

% Calculate the probabilities matrix using FCM.
[center, U, obj_fcn, prob_matrix_cell] = create_prob_matrices_from_array(nii.img, clusters);
for i = 1 : clusters
    prob_nii = make_nii(prob_matrix_cell{i});
    prob_nii.hdr.dime.pixdim = nii.hdr.dime.pixdim;
    save_nii(prob_nii, strcat(experiment_dest_folder, 'prob_', num2str(i), '.nii'));
end

% Calculate the clusters threshold. This returns a cell of binary images.
[umbraladas, mu, sigma] = split_images(prob_matrix_cell);
for i = 1 : clusters
    umbral_nii = make_nii(umbraladas{i});    
    umbral_nii.hdr.dime.pixdim = nii.hdr.dime.pixdim;
    save_nii(umbral_nii, strcat(experiment_dest_folder, 'umbral_', num2str(i), '.nii'));
end

clear center; 
clear U;
clear obj_fcn;
clear prob_matric_cell;

clean_volume = cell(1, clusters);
mesh_nodes = cell(1, clusters);
mesh_faces = cell(1, clusters);
for i = 1 : clusters    
    clean_volume{i} = fillholes3d(umbraladas{i},1);    
    % Save filled binary volume
    filled_volume_nii = make_nii(clean_volume{i});
    filled_volume_nii.hdr.dime.pixdim = nii.hdr.dime.pixdim;
    save_nii(filled_volume_nii, strcat(experiment_dest_folder, 'filled_', num2str(i), '.nii'));
    
    [v,f,regions,holes] = v2s(clean_volume{i},0.01, 0.1, 'simplify');
    [mesh_nodes{i},mesh_faces{i}]=meshcheckrepair(v,f);    
    clear regions;
    clear holes;
    mesh_nodes_transla{i} = trasladarEinvertir(v, nii.hdr.dime.pixdim);
    vertface2obj(mesh_nodes_transla{i}, f, strcat(experiment_dest_folder, 'cluster_', num2str(i), '.obj'));
end


% Options=struct;
% Options.Verbose=0;
% Options.Wedge=0.00005; %Si el valor es grande (0.0005) redondea mucho las formas o se pisa.
% Options.Wline=0;
% Options.Alpha=0.00004; % Este valor si es positivo aunque chico, la caga.
% Options.Beta=0.00008;
% Options.Kappa=2;
% Options.Delta=0;
% Options.Gamma=1;
% Options.Iterations=100;
% %no puede ser 0
% Options.Sigma1=2;
% %no puede ser 0
% Options.Sigma2=2;
% Options.Lambda=0.8;
% Options.GIterations = 20;
% FV = struct;
% 
% params = strcat('it', num2str(Options.Iterations),'we', num2str(Options.Wedge),'wl', num2str(Options.Wline), 'a', num2str(Options.Alpha), 'b',num2str(Options.Beta), 'd', num2str(Options.Delta), 'k', num2str(Options.Kappa),'s1',num2str(Options.Sigma1),'s2',num2str(Options.Sigma2));
% 
% for i = 2 : 2
%         FV.vertices = mesh_nodes{i};
%         FV.faces = mesh_faces{i};
% 
%         FV2 = CustomSnake3D(double(nii.img),FV,Options);
%         FV3 = FV2;
%         FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
%         
%         vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes', num2str(i),'_',params, '.obj'));    
% end

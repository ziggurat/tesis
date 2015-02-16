clear all;
close all;

% Configure the folders for reading the images and to save the experiments %%

% GT{i}.mesh.nodes
% GT{i}.mesh.faces
% GT{i}.mesh.trans_nodes
% 
% Todo_nofeatures{i}.prob
% Todo_nofeatures{i}.mu
% Todo_nofeatures{i}.sigma
% Todo_nofeatures{i}.mesh.nodes
% Todo_nofeatures{i}.mesh.faces
% Todo_nofeatures{i}.mesh.trans_nodes
% 
% Todo_gaussian{i}.prob
% Todo_gaussian{i}.mu
% Todo_gaussian{i}.sigma
% Todo_gaussian{i}.mesh.nodes
% Todo_gaussian{i}.mesh.faces
% Todo_gaussian{i}.mesh.trans_nodes



%images_root_fodler = 'c:/imagenes_3d';

for i=2:2
    images_root_folder = '/home/manuel/Tesis/imagenes_3d/';
    experiment_dest_folder = '/home/manuel/Tesis/versionado_git/results/';
    clusters = 4;
    
%     GT = cell(1,6);    
%     
%     gt_nii = load_nii(strcat(images_root_folder, 'IBSR_nifti_stripped/IBSR_0', num2str(i), '/IBSR_0',num2str(i),'_segTRI_fill_ana.nii'));
%     
%     cluster = cell(1, clusters);
%     clean_volume = cell(1, clusters);  
%     
%     for c = 1 : clusters
%         cluster{c} = gt_nii.img;
%         cluster{c}(cluster{c} ~= c-1) = 255;
%         cluster{c}(cluster{c} == c-1) = 1;
%         cluster{c}(cluster{c} == 255) = 0;
%         clean_volume{c} = fillholes3d(cluster{c},1);    
% 
%         [v,f,~,~]=v2s(clean_volume{c},0.01, 0.1, 'simplify');
%         [GT{c}.mesh.nodes{c},GT{c}.mesh.faces{c}]=meshcheckrepair(v,f);
%         GT{c}.mesh.nodes_trans{c} = trasladarEinvertir(GT{c}.mesh.nodes{c}, nii.hdr.dime.pixdim);
%         %vertface2obj(GT{c}.mesh.nodes_trans{c}, GT{c}.mesh.faces{c}, strcat(experiment_dest_folder, 'gt_mesh_', num2str(c), '.obj'));
%     end
%     
%     clear gt_nii;
    nii = load_nii(strcat(images_root_folder, 'IBSR_nifti_stripped/IBSR_0', num2str(i), '/IBSR_0',num2str(i),'__ana_strip.nii'));
    % Run Fuzzy with intensities only
    load(strcat(experiment_dest_folder, 'mallas_0', num2str(i), '.mat'));
    features = cell(1,0);
    Todo_nofeatures = cell(1, 6);    

    [~, ~, ~, nofeatures_prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
    
    [umbraladas, mu, sigma] = split_images(nofeatures_prob_matrix_cell);
    clean_volume = cell(1, clusters);    
    for c = 1 : clusters
        Todo_nofeatures{c}.prob = nofeatures_prob_matrix_cell{c};
        Todo_nofeatures{c}.mu = mu{c};
        Todo_nofeatures{c}.sigma = sigma{c};
        clean_volume{c} = fillholes3d(umbraladas{c},1);    

        [v,f,~,~] = v2s(clean_volume{c},0.01, 0.1, 'simplify');
        [Todo_nofeatures{c}.nodes,Todo_nofeatures{c}.faces]=meshcheckrepair(v,f);
        Todo_nofeatures{c}.trans_nodes = trasladarEinvertir(Todo_nofeatures{c}.nodes, nii.hdr.dime.pixdim);
        %vertface2obj(Todo_nofeatures{c}.trans_nodes, Todo_nofeatures{c}.faces, strcat(experiment_dest_folder, 'nofeatures_', num2str(c), '.obj'));
    end
    
    % Run fuzzy with intensity + gaussian
    features = cell(1,1);
    features{1} = imgaussian(nii.img, 2);
    Todo_gaussian = cell(1, 6);
    
    [~, ~, ~, nofeatures_prob_matrix_cell] = create_prob_matrices_from_array(nii.img, features, clusters);
    
    [umbraladas, mu, sigma] = split_images(nofeatures_prob_matrix_cell);
    clean_volume = cell(1, clusters);    
    for c = 1 : clusters
        Todo_gaussian{c}.prob = nofeatures_prob_matrix_cell{c};
        Todo_gaussian{c}.mu = mu{c};
        Todo_gaussian{c}.sigma = sigma{c};
        clean_volume{c} = fillholes3d(umbraladas{c},1);    

        [v,f,~,~] = v2s(clean_volume{c},0.01, 0.1, 'simplify');
        [Todo_gaussian{c}.nodes,Todo_gaussian{c}.faces]=meshcheckrepair(v,f);
        Todo_gaussian{c}.trans_nodes = trasladarEinvertir(Todo_gaussian{c}.nodes, nii.hdr.dime.pixdim);
        %vertface2obj(Todo_gaussian{c}.trans_nodes, Todo_gaussian{c}.faces, strcat(experiment_dest_folder, 'Todo_gaussian_', num2str(c), '.obj'));
    end
    
    save(strcat(experiment_dest_folder, 'mallas_0', num2str(i), '.mat'));
    clear all;    
end

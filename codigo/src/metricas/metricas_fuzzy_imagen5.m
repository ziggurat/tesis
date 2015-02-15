clear all;
close all;
root_path = '/home/cescuderol/Documents/tesis/tesis/';
%root_path = '/home/manuel/Tesis/versionado_git/';

load(strcat(root_path, '/distancias/mallas_05.mat'));

ground_mesh.nodes = gt_mesh_nodes;
ground_mesh.faces = gt_mesh_faces;
ground_mesh.trans_nodes = gt_mesh_nodes_trans;

% nofeatures{2} = gt_mesh_nodes_trans{1} = fondo
% nofeatures{3} = gt{4} = materia blanca
% nofeatures{1} = gt{3} = materia gris
% nofeatures{4} = gt{2} = liquido
distances.nofeatures = cell(1,4);
distances.nofeatures{1} = volumeForExperimentOnly(nofeatures, 3, ground_mesh, 4, 1);
distances.nofeatures{2} = volumeForExperimentOnly(nofeatures, 1, ground_mesh, 3, 1);
distances.nofeatures{3} = volumeForExperimentOnly(nofeatures, 4, ground_mesh, 2, 1);

% gaussian{2} = gt_mesh_nodes_trans{1} = fondo
% gaussian{4} = gt{4} = materia blanca
% gaussian{3} = gt{3} = materia gris
% gaussian{1} = gt{2} = liquido
distances.gaussian = cell(1,4);
distances.gaussian{1} = volumeForExperimentOnly(gaussian, 4, ground_mesh, 4, 1);
distances.gaussian{2} = volumeForExperimentOnly(gaussian, 3, ground_mesh, 3, 1);
distances.gaussian{3} = volumeForExperimentOnly(gaussian, 1, ground_mesh, 2, 1);


save(strcat(root_path, '/distancias/metrica_fuzzy_05.mat'), 'distances');

% figure,drawMesh(nofeatures.nodes{1},nofeatures.faces{1});
% figure,drawMesh(nofeatures.nodes{2},nofeatures.faces{2});
% figure,drawMesh(nofeatures.nodes{3},nofeatures.faces{3});
% figure,drawMesh(nofeatures.nodes{4},nofeatures.faces{4});


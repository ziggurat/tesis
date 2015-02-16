clear all;
close all;
root_path = '/home/cescuderol/Documents/tesis/results';
%root_path = '/home/manuel/Tesis/versionado_git/';

load(strcat(root_path, '/mallas_03.mat'));

% figure,drawMesh(GT{1}.mesh.nodes_trans{1},GT{1}.mesh.faces{1});
% figure,drawMesh(GT{2}.mesh.nodes_trans{2},GT{2}.mesh.faces{2});
% figure,drawMesh(GT{3}.mesh.nodes_trans{3},GT{3}.mesh.faces{3});
% figure,drawMesh(GT{4}.mesh.nodes_trans{4},GT{4}.mesh.faces{4});
% 
% figure,drawMesh(Todo_nofeatures{1}.trans_nodes,Todo_nofeatures{1}.faces);
% figure,drawMesh(Todo_nofeatures{2}.trans_nodes,Todo_nofeatures{2}.faces);
% figure,drawMesh(Todo_nofeatures{3}.trans_nodes,Todo_nofeatures{3}.faces);
% figure,drawMesh(Todo_nofeatures{4}.trans_nodes,Todo_nofeatures{4}.faces);
% 
% figure,drawMesh(Todo_gaussian{1}.trans_nodes,Todo_gaussian{1}.faces);
% figure,drawMesh(Todo_gaussian{2}.trans_nodes,Todo_gaussian{2}.faces);
% figure,drawMesh(Todo_gaussian{3}.trans_nodes,Todo_gaussian{3}.faces);
% figure,drawMesh(Todo_gaussian{4}.trans_nodes,Todo_gaussian{4}.faces);

%No Features

distances.nofeatures = cell(1,4);
distances.nofeatures{1} = volumeForExperimentOnly(Todo_nofeatures{3}, GT{4}.mesh, 4, 1);
distances.nofeatures{2} = volumeForExperimentOnly(Todo_nofeatures{4}, GT{3}.mesh, 3, 1);
distances.nofeatures{3} = volumeForExperimentOnly(Todo_nofeatures{1}, GT{2}.mesh, 2, 1);

% Gaussian

distances.gaussian = cell(1,4);
distances.gaussian{1} = volumeForExperimentOnly(Todo_gaussian{1}, GT{4}.mesh, 4, 1);
distances.gaussian{2} = volumeForExperimentOnly(Todo_gaussian{3}, GT{3}.mesh, 3, 1);
distances.gaussian{3} = volumeForExperimentOnly(Todo_gaussian{4}, GT{2}.mesh, 2, 1);


save(strcat(root_path, '/metrica_fuzzy_03.mat'), 'distances');

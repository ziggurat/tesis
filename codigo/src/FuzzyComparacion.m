clear all;
close all;

load('/home/cescuderol/Documents/tesis/tesis/resultados_02_14/IBSR2/mallas_02.mat');

% nofeatures{1} = gt_mesh_nodes_trans{1} = fondo
% nofeatures{2} = gt{4}
% nofeatures{3} = gt{3}
% nofeatures{4} = gt{2}
distances.nofeatures = cell(1,4);
distances.nofeatures{1} = volumeForExperimentOnly(nofeatures, 2, gt_mesh, 4, 1);
distances.nofeatures{2} = volumeForExperimentOnly(nofeatures, 3, gt_mesh, 3, 1);
distances.nofeatures{3} = volumeForExperimentOnly(nofeatures, 4, gt_mesh, 2, 1);

% gaussian{3} = gt_mesh_nodes_trans{1} = fondo
% gaussian{1} = gt{3}
% gaussian{2} = gt{2}
% gaussian{4} = gt{4}
distances.gaussian = cell(1,4);
distances.gaussian{1} = volumeForExperimentOnly(gaussian, 1, gt_mesh, 3, 1);
distances.gaussian{2} = volumeForExperimentOnly(gaussian, 2, gt_mesh, 2, 1);
distances.gaussian{3} = volumeForExperimentOnly(gaussian, 4, gt_mesh, 4, 1);

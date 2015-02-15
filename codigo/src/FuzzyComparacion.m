clear all;
close all;

var1 = '/home/cescuderol/Documents/tesis/tesis/resultados_02_14/IBSR1/mallas_01.mat';
load(var1);

distances(1).nofeatures = volumeForExperimentOnly(nofeatures, 2, gt_mesh, 2, 1);
distances(1).gaussian = volumeForExperimentOnly(gaussian, 2, gt_mesh, 2, 1);
distances(1).gradient = volumeForExperimentOnly(gradient, 2, gt_mesh, 2, 1);
distances(1).all = volumeForExperimentOnly(all, 2, gt_mesh, 2, 1);


var2 = '/home/cescuderol/Documents/tesis/tesis/resultados_02_14/IBSR2/mallas_02.mat';

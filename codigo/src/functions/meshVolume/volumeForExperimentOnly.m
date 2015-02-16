function [ volume ] = volumeForExperimentOnly(mesh, ground_mesh, gt_index, gap)
%VOLUMEFOREXPERIMENTONLY Summary of this function goes here
%   Detailed explanation goes here
    [points, directionVec] = createRayGridFromMesh( ground_mesh.nodes_trans{gt_index}, mesh.trans_nodes, gap );
    volume = meshVolumeQualityInd(points, directionVec, ground_mesh.nodes_trans{gt_index}, ground_mesh.faces{gt_index}, mesh.trans_nodes, mesh.faces, gap);
end


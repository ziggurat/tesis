function [ volume ] = volumeForExperimentOnly(mesh, mesh_index, gt_mesh, gt_index, gap)
%VOLUMEFOREXPERIMENTONLY Summary of this function goes here
%   Detailed explanation goes here
    [points, directionVec] = createRayGridFromMesh( gt_mesh.trans_nodes{gt_index}, mesh.trans_nodes{mesh_index}, gap );
    volume = meshVolumeQualityInd(points, directionVec, gt_mesh.trans_nodes{gt_index}, gt_mesh.faces{gt_index}, mesh.trans_nodes{mesh_index}, mesh.faces{mesh_index}, gap);
end


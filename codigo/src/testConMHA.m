MHA_T1 = mha_read_volume('/home/cescuderol/Downloads/Custom (1)/SimBRATS_HG0001/SimBRATS_HG0001_T1.mha');
MHA_T2 = mha_read_volume('/home/cescuderol/Downloads/Custom (1)/SimBRATS_HG0001/SimBRATS_HG0001_T2.mha');
MHA_GT = mha_read_volume('/home/cescuderol/Downloads/Custom (1)/SimBRATS_HG0001_complete_truth.mha');
clusters = 6;

GT.umbralado = cell(1, clusters);
GT.clean_volume = cell(1, clusters);

features = cell(1,1);
features{1} = MHA_T2;

mha = cell(1, clusters);
[~, ~, ~, mha.prob_matrix] = create_prob_matrices_from_array(MHA_T1, features, clusters);
[umbraladas, mu, sigma] = split_images(mha.prob_matrix);
 
for c = 1 : clusters    
    mha.clean_volume{c} = fillholes3d(umbraladas{c},1);    

    [mha.v{c},mha.f{c},~,~] = v2s(mha.clean_volume{c},0.01, 0.1, 'simplify');
    [mha.nodes{c},mha.faces{c}]=meshcheckrepair(mha.v{c},mha.f{c});
    %mha{c}.trans_nodes = trasladarEinvertir(mha{c}.nodes, nii.hdr.dime.pixdim);
    vertface2obj(mha.nodes{c}, mha.faces{c}, strcat('mha_', num2str(c), '.obj'));
    
    GT.umbralado{c} = MHA_GT;
    GT.umbralado{c}(GT.umbralado{c} ~= c-1) = 255;
    GT.umbralado{c}(GT.umbralado{c} == c-1) = 1;
    GT.umbralado{c}(GT.umbralado{c} == 255) = 0;
    GT.clean_volume{c} = fillholes3d(GT.umbralado{c},1);    

    [v,f,~,~]=v2s(clean_volume{c},0.01, 0.1, 'simplify');
    [GT.mesh.nodes{c},GT.mesh.faces{c}]=meshcheckrepair(v,f);
    %GT.mesh.nodes_trans{c} = trasladarEinvertir(GT.mesh.nodes{c}, nii.hdr.dime.pixdim);
    vertface2obj(GT.mesh.nodes{c}, GT.mesh.faces{c}, strcat(experiment_dest_folder, 'mha_gt_mesh_', num2str(c), '.obj'));
    
end
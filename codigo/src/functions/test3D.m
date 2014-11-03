clear;
close all;
iptsetpref('ImshowBorder','tight');
clusters = 4;
nii = load_nii('/home/manuel/Tesis/imagenes_3d/IBSR_nifti_stripped/IBSR_01/IBSR_01_ana_strip.nii');
original = nii.img;
[center, U, obj_fcn, prob_matrix_cell] = create_prob_matrices_from_array(original, clusters);

cluster_images = split_images(prob_matrix_cell);
clear nii;
clear center; 
clear U;
clear obj_fcn;
clear prob_matric_cell;


clean_volume = cell(1, clusters);
newnode = cell(1, clusters);
newface = cell(1, clusters);
for i = 1 : clusters
    clean_volume{i} = deislands3d(cluster_images{i},1);
    [v,f,regions,holes]=v2s(clean_volume{i},0.1, 2);
    [newnode{i},newface{i}]=meshcheckrepair(v,f);
    clear regions;
    clear holes;    
    vertface2obj(newnode{i}, newface{i}, strcat('cluster', num2str(i), '.obj'));
end

% cluster_to_process = permute(cluster_images{3}, [2,1,3]);
% for i = 1 : min(size(cluster_to_process))    
%     cluster_to_process(i,:,:) = removeNoiseAndFillHoles(cluster_to_process(i,:,:));
% end
% cluster_to_process2 = permute(cluster_to_process, [2,1,3]);

%nii = make_nii(cluster_images{1});
%save_nii(nii, 'cluster1.nii');



%picked_cluster = input('Cluster number?');

Options=struct;
Options.Verbose=0;
Options.Wedge=0;
Options.Wline=-1;
Options.Alpha=0.2;
Options.Beta=0.2;
Options.Kappa=0.5;
Options.Delta=0.1000;
Options.Gamma=1;
Options.Iterations=1;
Options.Sigma1=2;
Options.Sigma2=2;
Options.Lambda=0.8;
FV = struct;
FV.vertices = newnode{1};
clean_face = newface{1};
%clean_face(:,1) = [];
FV.faces = clean_face;
FV2=Snake3D(double(original),FV,Options);
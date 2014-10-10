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

%nii = make_nii(cluster_images{1});
%save_nii(nii, 'cluster1.nii');

[v,f,regions,holes]=v2s(double(cluster_images{4}),0.1, 7);
clear regions;
clear holes;
%figure, plotsurf(v, f);
%vertface2obj(v, f, 'cluster_4.obj');

%picked_cluster = input('Cluster number?');

Options=struct;
Options.Verbose=0;
Options.Wedge=0;
Options.Wline=-1;
Options.Alpha=0.2;
Options.Beta=0.2;
Options.Kappa=0.5;
Options.Delta=0.1000;
Options.Gamma=0.1000;
Options.Iterations=20;
Options.Sigma1=2;
Options.Sigma2=2;
Options.Lambda=0.8;
FV = struct;
FV.vertices = v;
clean_face = f;
clean_face(:,1) = [];
FV.faces = clean_face;
FV2=Snake3D(double(original),FV,Options);
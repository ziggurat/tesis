clear;
close all;
iptsetpref('ImshowBorder','tight');
clusters = 4;
nii = load_nii('/home/manuel/Tesis/imagenes_3d/IBSR_nifti_stripped/IBSR_01/IBSR_01_ana_strip.nii');
original = nii.img;
[center, U, obj_fcn, prob_matrix_cell] = create_prob_matrices_from_array(original, clusters);
dimensions = size(original);

cluster_images = split_images(prob_matrix_cell);

%[node1,elem1,face1]=v2m(double(cluster_images{4}),0.5,5,100);
[node1,elem1,face1]=v2m(double(cluster_images{1}),0.5,5,100);
[node2,elem2,face2]=v2m(double(cluster_images{2}),0.5,5,100);
[node3,elem3,face3]=v2m(double(cluster_images{3}),0.5,5,100);
[node4,elem4,face4]=v2m(double(cluster_images{4}),0.5,5,100);
figure, plotsurf(node1, face1);
figure, plotsurf(node2, face2);
figure, plotsurf(node3, face3);
figure, plotsurf(node4, face4);


%picked_cluster = input('Cluster number?');

Options=struct;
Options.Verbose=1;
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
%FV.vertices = node1;
%clean_face = face1;
%clean_face(:,1) = [];
%FV.faces = face1;
%FV2=Snake3D(double(original),FV,Options);
%h=plotsurf(FV2.vertices,FV2.faces);
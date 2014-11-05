clear;
close all;
iptsetpref('ImshowBorder','tight');
clusters = 4;
nii = load_nii('/home/manuel/Tesis/imagenes_3d/IBSR_nifti_stripped/IBSR_01/IBSR_01_ana_strip.nii');
original = nii.img;
[center, U, obj_fcn, prob_matrix_cell] = create_prob_matrices_from_array(original, clusters);
dimensions = size(original);

cluster_images = split_images(prob_matrix_cell);

D = squeeze(cluster_images{2});

my_cm = [0,0,0; 0,1,0];
figure
colormap(my_cm)
image_num = 125;
imagesc(D(:,:,image_num))
axis image

figure
colormap(my_cm)
contourslice(D,[],[],[60,80,100,120],8);
view(3);
axis tight

figure
colormap(my_cm)
Ds = smooth3(D);
hiso = patch(isosurface(Ds,5),...
   'FaceColor',[1,.75,.65],...
   'EdgeColor','none');
   isonormals(Ds,hiso)
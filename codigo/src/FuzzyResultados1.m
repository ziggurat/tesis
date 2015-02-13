clear all;
close all;

% Configure the folders for reading the images and to save the experiments %%

images_root_folder = '/home/manuel/Tesis/imagenes_3d/'; 
%images_root_fodler = 'c:/imagenes_3d';

experiment_dest_folder = '/home/manuel/Tesis/masTeValeQueAndes/';
mkdir(strcat(experiment_dest_folder));

nii = load_nii(strcat(images_root_folder, 'IBSR_nifti_stripped/IBSR_01/IBSR_01_ana_strip.nii'));

features = cell(1,1);

grad = gradient(double(nii.img));
figure, imshow3D(nii.img)
%figure, imshow3D(grad);


% clusters = 4;
% features{1} = imgaussian(nii.img, 2);
% fuzzy_input = add_features_to_image(nii.img, features);
% 
% 
% 
% [center, U, obj_fcn, prob_matrix_cell] = create_prob_matrices_from_array(fuzzy_input, clusters);
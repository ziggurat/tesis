clear;
original = read_images_folder('C:\Users\Manuel\Documents\MATLAB\images\phantom\phantom_sphere1');
image_array = cell_image_to_3d_array(original);
flat_array = image_array(:);
flat_array = normalize_array(flat_array);
[center, U, obj_fcn] = fcm_from_image_array(flat_array, 3, [2.0, 50, 1e-5,1]);
show_clusters_figures(  U, 30, original );
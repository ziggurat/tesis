clear;
clearvars;
clear functions;
original = read_images_folder('C:\Users\Manuel\Documents\MATLAB\images\phantom\phantom_sphere3');
image_array = cell_image_to_array(original);
flat_array4 = flatten_image_with_coordinates(image_array);
[center1, U1, obj_fcn1] = fcm_from_image_array(flat_array4, 3, [2.0, 75, 1e-7]);
show_clusters_figures(  U1, 30, original );

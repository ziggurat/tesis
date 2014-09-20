clear;
original = read_images_folder('C:\Users\Manuel\Documents\MATLAB\images\phantom\phantom_sphere1');
image_array = cell_image_to_array(original);
flat_array = image_array(:);
flat_array4 = flatten_image_with_coordinates(image_array);
[center, U, obj_fcn] = fcm_from_image_array(flat_array, 3, [2.0, 50, 1e-5,1]);
[center1, U1, obj_fcn1] = fcm_from_image_array(flat_array4, 3, [2.0, 75, 1e-7,1]);

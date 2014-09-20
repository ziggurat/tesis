function [ center, U, obj_fcn, prob_matrix_cell ] = create_prob_matrices_from_array( image_array, cluster_qty )
    % Recibe como parametro de entrada una matriz que representa una imagen
    % 2D o 3D y la cantidad de clusters en los cuales dividir la imagen.
    % Retorna un cell de matrices de probabilidades (una por cluster).    
    dimensions = size(image_array);
    %single_image_array = zeros(dimensions, 'single');
    single_image_array = single(image_array);
    flat_array = single_image_array(:);
    flat_array = normalize_array(flat_array);
    [center, U, obj_fcn] = fcm_custom(flat_array, cluster_qty, [2.0, 200, 1e-5,1]);
    
    % Creo un cell del tamaño de la cantidad de clusters
    prob_matrix_cell = cell(1, cluster_qty);
    % Recorro desde 1 hasta la cantidad de clusters y almaceno las matrices
    % de pertenenticias en el cell.
    for cnt = 1 : cluster_qty
        prob_matrix_cell{cnt} = reshape(U(cnt, :), dimensions);
    end    

end


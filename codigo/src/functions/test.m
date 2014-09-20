clear;
close all;
iptsetpref('ImshowBorder','tight');
clusters = 4;
original = imread('/home/manuel/Tesis/versionado_git/escritura/Tesis/images/artificial_snakes_1_bias_gaussian.png');
[center, U, obj_fcn, prob_matrix_cell] = create_prob_matrices_from_array(original, clusters);
dimensions = size(original);
for cnt = 1 : clusters
    handle = figure(cnt);
    to_plot = reshape(U(cnt, :), dimensions);
    imagesc(to_plot);
    axis off;        
    set(gca,'Position',[0 0 1 1]); % Make the axes occupy the hole figure
    truesize;
end
cluster_images = split_images(prob_matrix_cell);
for cnt = 1 : max(size(cluster_images))
    figure;
    imshow(cluster_images{cnt});    
end

% Remove noise by filling holes and cleaning the background
picked_cluster = input('Cluster number?');
filled_holes = imfill(cluster_images{picked_cluster}, 'holes');
figure, imshow(filled_holes);
no_noise = bwareaopen(filled_holes, 10);
figure, imshow(no_noise);

% Get the boundaries of the object
B = bwboundaries(no_noise);
P = B{1};
figure, imshow(original), hold on; plot(P(:,2),P(:,1),'b.'); hold on;
Options=struct;
Options.Verbose=true;
Options.Iterations=200;
Options.nPoints = 5000;
Options.Wedge=2.0;
Options.Wline=0.0001; % Si pongo positivo tiende hacia lineas negras, sino hacia lineas blancas.
Options.Wterm=0.1;
Options.Sigma1=8;
Options.Sigma2=10;
Options.Alpha=0.2;
Options.Beta=0.2;
Options.Delta=0.01;
Options.Kappa=0.001;

[O,J]=Snake2D(original,P,Options);


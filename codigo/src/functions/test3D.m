clear;
close all;
iptsetpref('ImshowBorder','tight');
clusters = 4;
nii = load_nii('c:/imagenes_3d/IBSR_nifti_stripped/IBSR_01/IBSR_01_ana_strip.nii');
original = nii.img;
[center, U, obj_fcn, prob_matrix_cell] = create_prob_matrices_from_array(original, clusters);

cluster_images = split_images(prob_matrix_cell);
clear center; 
clear U;
clear obj_fcn;
clear prob_matric_cell;

clean_volume = cell(1, clusters);
newnode = cell(1, clusters);
newface = cell(1, clusters);
for i = 1 : clusters
    clean_volume{i} = deislands3d(cluster_images{i},1);
    clean_volume{i} = fillholes3d(clean_volume{i},1);
    [v,f,regions,holes] = v2s(clean_volume{i},0.1, 0.1, 'simplify');
    [newnode{i},newface{i}] = meshcheckrepair(v,f);
    clear regions;
    clear holes;
    newnodetosave{i} = trasladarEinvertir(newnode{i}, nii.hdr.dime.pixdim);
    vertface2obj(newnodetosave{i}, newface{i}, strcat('c:\Users\Manuel\cluster', num2str(i), '.obj'));
end

Options=struct;
Options.Verbose=0;
Options.Wedge=0;
Options.Wline=-1;
Options.Alpha=0.2;
Options.Beta=0.2;
Options.Kappa=0.5;
Options.Delta=0.1;
Options.Gamma=0.1;
Options.Iterations=15;
Options.Sigma1=2;
Options.Sigma2=2;
Options.Lambda=0.8;
FV = struct;

for i = 1 : clusters
    if (max(size(newface{i})) < 30000)
        FV.vertices = newnode{i};
        FV.faces = newface{i};

        FV2 = Snake3D(prob_matrix_cell{i},FV,Options);
        FV3 = FV2;
        FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
        
        vertface2obj(FV3.vertices, FV3.faces, strcat('c:\Users\Manuel\cluster_snake_default', num2str(i), '.obj'));
    end
end




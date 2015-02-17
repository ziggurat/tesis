clear all;
close all;

% Configure the folders for reading the images and to save the experiments %%

experiment_dest_folder = '/home/cescuderol/Documents/tesis/results/';
obj_folder = strcat(experiment_dest_folder,'obj/');
mkdir(strcat(obj_folder));

for i=3:9
    if i == 2
        continue;
    end
    experiment_dest_folder = '/home/cescuderol/Documents/tesis/results/';
    load(strcat(experiment_dest_folder, 'mallas_0', num2str(i), '.mat'));
    experiment_dest_folder = '/home/cescuderol/Documents/tesis/results/';
    obj_folder = strcat(experiment_dest_folder,'objst/');
    
    %vertface2obj(GT{2}.mesh.nodes_trans{2}, GT{2}.mesh.faces{2}, strcat(obj_folder,'IMG', num2str(i), '_GT_liquido', '.obj'));
    %vertface2obj(GT{3}.mesh.nodes_trans{3}, GT{3}.mesh.faces{3}, strcat(obj_folder,'IMG', num2str(i), '_GT_gris', '.obj'));
    %vertface2obj(GT{4}.mesh.nodes_trans{4}, GT{4}.mesh.faces{4}, strcat(obj_folder,'IMG', num2str(i), '_GT_blanca', '.obj'));
    
    
    % Run Snake with intensities only    
    for c = 1 : 4
        switch i
            case 1
                switch c
                    case 1
                        fileNameNF = 'nofeatures_liquido';
                        fileNameGA = 'fondo';
                    case 2
                        fileNameNF = 'nofeatures_gris';
                        fileNameGA = 'gauss_liquido';
                    case 3
                        fileNameNF = 'nofeatures_blanca';
                        fileNameGA = 'gauss_gris';
                    case 4
                        fileNameNF = 'fondo';
                        fileNameGA = 'gauss_blanca';
                end
            case 2
                switch c
                    case 1
                        fileNameNF = 'nofeatures_blanca';
                        fileNameGA = 'gauss_liquido';
                    case 2
                        fileNameNF = 'nofeatures_gris';
                        fileNameGA = 'gauss_blanca';
                    case 3
                        fileNameNF = 'fondo';
                        fileNameGA = 'fondo';
                    case 4
                        fileNameNF = 'nofeatures_liquido';
                        fileNameGA = 'gauss_gris';
                end
            case 3
                switch c
                    case 1
                        fileNameNF = 'nofeatures_liquido';
                        fileNameGA = 'gauss_blanca';
                    case 2
                        fileNameNF = 'fondo';
                        fileNameGA = 'fondo';
                    case 3
                        fileNameNF = 'nofeatures_blanca';
                        fileNameGA = 'gauss_gris';
                    case 4
                        fileNameNF = 'nofeatures_gris';
                        fileNameGA = 'gauss_liquido';
                end
            case 4
                switch c
                    case 1
                        fileNameNF = 'nofeatures_liquido';
                        fileNameGA = 'fondo';
                    case 2
                        fileNameNF = 'nofeatures_blanca';
                        fileNameGA = 'gauss_blanca';
                    case 3
                        fileNameNF = 'nofeatures_gris';
                        fileNameGA = 'gauss_gris';
                    case 4
                        fileNameNF = 'fondo';
                        fileNameGA = 'gauss_liquido';
                end
            case 5
                switch c
                    case 1
                        fileNameNF = 'nofeatures_blanca';
                        fileNameGA = 'gauss_gris';
                    case 2
                        fileNameNF = 'nofeatures_liquido';
                        fileNameGA = 'gauss_liquido';
                    case 3
                        fileNameNF = 'fondo';
                        fileNameGA = 'fondo';
                    case 4
                        fileNameNF = 'nofeatures_gris';
                        fileNameGA = 'gauss_blanca';
                end
            case 6
                switch c
                    case 1                        
                        fileNameNF = 'fondo';
                        fileNameGA = 'fondo';
                    case 2
                        fileNameNF = 'nofeatures_blanca';
                        fileNameGA = 'gauss_gris';
                    case 3
                        fileNameNF = 'nofeatures_liquido';
                        fileNameGA = 'gauss_liquido';
                    case 4
                        fileNameNF = 'nofeatures_gris';
                        fileNameGA = 'gauss_blanca';
                end
            case 7
                switch c
                    case 1                        
                        fileNameNF = 'nofeatures_gris';
                        fileNameGA = 'gauss_liquido';
                    case 2
                        fileNameNF = 'nofeatures_blanca';
                        fileNameGA = 'gauss_blanca';
                    case 3
                        fileNameNF = 'nofeatures_liquido';
                        fileNameGA = 'gauss_gris';
                    case 4
                        fileNameNF = 'fondo';
                        fileNameGA = 'fondo';                        
                end
            case 8
                switch c
                    case 1                        
                        fileNameNF = 'fondo';
                        fileNameGA = 'gauss_gris';
                    case 2
                        fileNameNF = 'nofeatures_blanca';
                        fileNameGA = 'gauss_blanca';
                    case 3
                        fileNameNF = 'nofeatures_liquido';
                        fileNameGA = 'fondo';
                    case 4
                        fileNameNF = 'nofeatures_gris';
                        fileNameGA = 'gauss_liquido';
                end
            case 9
                switch c
                    case 1                        
                        fileNameNF = 'nofeatures_liquido';
                        fileNameGA = 'gauss_gris';
                    case 2
                        fileNameNF = 'fondo';
                        fileNameGA = 'fondo';
                    case 3
                        fileNameNF = 'nofeatures_blanca';
                        fileNameGA = 'gauss_blanca';
                    case 4
                        fileNameNF = 'nofeatures_gris';
                        fileNameGA = 'gauss_liquido';
                end
        end
        
        Options.Gamma=1;
        Options.Sigma1=2;
        Options.Sigma2=1;
        Options.Iterations=50;

        Options.C = 0.08;
        Options.A = 0.03;
        Options.B = 0.03;
        Options.D = 1;
        Options.K = 8;
        
        if (max(strcmp(fileNameNF,{'fondo', 'nofeatures_blanca', 'gauss_blanca', 'gauss_liquido', 'nofeatures_liquido'})) == 0)
        
            fuzzyMeshName = strcat('IMG', num2str(i), '_fuzzy_', fileNameNF);
            %vertface2obj(Todo_nofeatures{c}.trans_nodes, Todo_nofeatures{c}.faces, strcat(obj_folder,fuzzyMeshName, '.obj'));
            
            I = Todo_nofeatures{c}.prob;
            FV.vertices = Todo_nofeatures{c}.nodes;
            FV.faces = Todo_nofeatures{c}.faces;
            Options.mu = Todo_nofeatures{c}.mu;
            Options.sigma = Todo_nofeatures{c}.sigma;                                


            name_obj = strcat('IMG', num2str(i), '_snakes_', fileNameNF);
            FV2 = NuevoCustomSnake3D(I,FV,Options);
            
            FV3 = FV2;
            FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);            
            
            vertface2obj(FV3.vertices, FV3.faces, strcat(obj_folder,name_obj, '.obj'));            
        end
    
        if (max(strcmp(fileNameGA,{'fondo', 'nofeatures_blanca', 'gauss_blanca', 'gauss_liquido', 'nofeatures_liquido'})) == 0)
            fuzzyMeshName = strcat('IMG', num2str(i), '_fuzzy_', fileNameGA);
            %vertface2obj(Todo_gaussian{c}.trans_nodes, Todo_gaussian{c}.faces, strcat(obj_folder,fuzzyMeshName, '.obj'));


            I = Todo_gaussian{c}.prob;
            FV.vertices = Todo_gaussian{c}.nodes;
            FV.faces = Todo_gaussian{c}.faces;
            Options.mu = Todo_gaussian{c}.mu;
            Options.sigma = Todo_gaussian{c}.sigma;                

            name_obj = strcat('IMG', num2str(i), '_snakes_', fileNameGA);        
            FV2 = NuevoCustomSnake3D(I,FV,Options);       
            
            FV3 = FV2;
            FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
            
            vertface2obj(FV3.vertices, FV3.faces, strcat(obj_folder,name_obj, '.obj'));               
        end
    end
    
    save(strcat(experiment_dest_folder, 'mallas_0', num2str(i), '.mat'));
    clear all;    
end

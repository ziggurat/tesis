clear all;
close all;

% Configure the folders for reading the images and to save the experiments %%

experiment_dest_folder = '/home/manuel/Tesis/versionado_git/results/';
obj_folder = strcat(experiment_dest_folder,'obj/');
mkdir(strcat(obj_folder));

for i=1:9    
    experiment_dest_folder = '/home/manuel/Tesis/versionado_git/results/';
    load(strcat(experiment_dest_folder, 'mallas_0', num2str(i), '.mat'));
    experiment_dest_folder = '/home/manuel/Tesis/versionado_git/results/';
    obj_folder = strcat(experiment_dest_folder,'obj/');
    
    vertface2obj(GT{2}.mesh.nodes_trans{2}, GT{2}.mesh.faces{2}, strcat('IMG', num2str(i), '_GT_liquido', '.obj'));
    vertface2obj(GT{3}.mesh.nodes_trans{3}, GT{3}.mesh.faces{3}, strcat('IMG', num2str(i), '_GT_gris', '.obj'));
    vertface2obj(GT{4}.mesh.nodes_trans{4}, GT{4}.mesh.faces{4}, strcat('IMG', num2str(i), '_GT_blanca', '.obj'));
    
    
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
        
        fuzzyMeshName = strcat('IMG', num2str(i), '_fuzzy_', fileNameNF);
        vertface2obj(Todo_nofeatures{c}.trans_nodes, Todo_nofeatures{c}.faces, strcat(fuzzyMeshName, '.obj'));
        
        fuzzyMeshName = strcat('IMG', num2str(i), '_fuzzy_', fileNameGA);
        vertface2obj(Todo_gaussian{c}.trans_nodes, Todo_gaussian{c}.faces, strcat(fuzzyMeshName, '.obj'));
                        
        Options.Gamma=1;
        Options.Sigma1=2;
        Options.Sigma2=1;
        Options.Iterations=50;
        
        Options.C = 0.05;
        Options.A = 0.03;
        Options.B = 0.03;
        Options.D = 1;
        Options.K = 3;
        
        I = Todo_nofeatures{c}.prob;
        FV.vertices = Todo_nofeatures{c}.trans_nodes;
        FV.faces = Todo_nofeatures{c}.faces;
        Options.mu = Todo_nofeatures{c}.mu;
        Options.sigma = Todo_nofeatures{c}.sigma;                                
                
        
        name_obj = strcat('IMG', num2str(i), '_snakes_', fileNameNF);
        FV2 = NuevoCustomSnake3D(I,FV,Options);              
        vertface2obj(FV2.vertices, FV2.faces, strcat(obj_folder,name_obj, '.obj'));   
        Todo_nofeatures{c}.snakes = FV2;
    
        I = Todo_gaussian{c}.prob;
        FV.vertices = Todo_gaussian{c}.trans_nodes;
        FV.faces = Todo_gaussian{c}.faces;
        Options.mu = Todo_gaussian{c}.mu;
        Options.sigma = Todo_gaussian{c}.sigma;                
        
        name_obj = strcat('IMG', num2str(i), '_snakes_', fileNameGA);        
        FV2 = NuevoCustomSnake3D(I,FV,Options);              
        vertface2obj(FV2.vertices, FV2.faces, strcat(obj_folder,name_obj, '.obj'));   
        Todo_gaussian{c}.snakes = FV2;
    end
    
    save(strcat(experiment_dest_folder, 'mallas_0', num2str(i), '.mat'));
    clear all;    
end

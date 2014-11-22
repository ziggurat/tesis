base_url = 'c:\Users\Manuel\experimentos2\';

Options=struct;
Options.Verbose=0;
Options.Wedge=0.1;
Options.Wline=0;
Options.Alpha=0.01;
Options.Beta=0.01;
Options.Kappa=2;
Options.Delta=0.15; %% Hay que jugar con este valor pero variarlo muy poco
Options.Gamma=1;
Options.Iterations=20;
%no puede ser 0
Options.Sigma1=2;
%no puede ser 0
Options.Sigma2=2;
Options.Lambda=0.8;
FV = struct;
FV.vertices = mesh_nodes{4};
FV.faces = mesh_faces{4};

while Options.Wedge < 0.5   
    while Options.Alpha < 0.09        
        while Options.Beta < 0.09            
            while Options.Kappa < 2.5                
                while Options.Delta < 0.25
                    params = strcat('it', num2str(Options.Iterations),'we', num2str(Options.Wedge),'wl', num2str(Options.Wline), 'a', num2str(Options.Alpha), 'b',num2str(Options.Beta), 'd', num2str(Options.Delta), 'k', num2str(Options.Kappa),'s1',num2str(Options.Sigma1),'s2',num2str(Options.Sigma2));                    
                    FV2 = CustomSnake3D(prob_matrix_cell{4},FV,Options);                    
                    hd = HausdorffDist(gt_mesh_nodes{4}, FV2.vertices);
                    fileID = fopen(strcat(base_url, 'results3.txt'),'a');
                    fprintf(fileID, params);
                    fprintf(fileID, ': ');                    
                    fprintf(fileID, num2str(hd));
                    fprintf(fileID, '\n');
                    fclose(fileID);
                    clear FV2;
                    clear FV3;
                    Options.Delta = Options.Delta + 0.03;
                end
                Options.Delta = 0.2;
                Options.Kappa = Options.Kappa + 0.1;
            end
            Options.Kappa = 2;
            Options.Beta = Options.Beta + 0.03;
        end
        Options.Beta = 0.01;
        Options.Alpha = Options.Alpha + 0.03;
    end
    Options.Alpha = 0.01;
    Options.Wedge = Options.Wedge + 0.1;
end
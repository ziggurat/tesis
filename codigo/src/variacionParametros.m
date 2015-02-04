experiment_dest_folder = '/home/manuel/Tesis/exp4/';
mkdir(strcat(experiment_dest_folder));

Options=struct;
Options.Verbose=0;
Options.Wedge=0;
Options.Wline=0;
Options.Alpha=0;
Options.Beta=0;
Options.Kappa=2;
Options.Delta=0; %% Cuanto mas grande el delta peor la distancia
Options.Gamma=1;
Options.Iterations=50;
%no puede ser 0
Options.Sigma1=2;
%no puede ser 0
Options.Sigma2=2;
Options.Lambda=0.8;
FV = struct;
FV.vertices = mesh_nodes{3};
FV.faces = mesh_faces{3};

% fileID = fopen(strcat(experiment_dest_folder, 'results.csv'),'a');
% fprintf(fileID, 'it, wedge, alpha, beta, delta, distancia');
% fprintf(fileID, '\n');
% fclose(fileID);
% while Options.Wedge < 0.0003
%     while Options.Alpha < 0.0001
%         while Options.Beta < 0.0001           
%             while Options.Alpha < 0.5
%                 params = strcat(num2str(Options.Iterations),',', num2str(Options.Wedge),',', num2str(Options.Alpha), ',',num2str(Options.Beta), ',', num2str(Options.Delta));                    
%                 FV2 = CustomSnake3D(prob_matrix_cell{3},FV,Options);                    
%                 hd = HausdorffDist(gt_mesh_nodes{4}, FV2.vertices);
%                 fileID = fopen(strcat(experiment_dest_folder, 'results.csv'),'a');
%                 fprintf(fileID, params);
%                 fprintf(fileID, ',');                    
%                 fprintf(fileID, num2str(hd));
%                 fprintf(fileID, '\n');
%                 fclose(fileID);
%                 
%                 FV3 = FV2;
%                 FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
%                 vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
%                 clear FV2;
%                 clear FV3;
%                 Options.Alpha = Options.Alpha + 0.1;
%             end
%             Options.Delta = 0;   
%             Options.Beta = Options.Beta + 0.00002;
%         end
%         Options.Beta = 0;
%         Options.Alpha = Options.Alpha + 0.00002;
%     end
%     Options.Alpha = 0;
%     Options.Wedge = Options.Wedge + 0.00005;
% end

experiment_dest_folder = '/home/manuel/Tesis/expDeA001/Alpha/';
mkdir(strcat(experiment_dest_folder));
Options.Alpha=0;
while Options.Alpha < 0.05
    params = strcat(num2str(Options.Iterations),',', num2str(Options.Wedge),',', num2str(Options.Alpha), ',',num2str(Options.Beta), ',', num2str(Options.Delta));                    
    FV2 = CustomSnake3D(prob_matrix_cell{3},FV,Options);                    

    FV3 = FV2;
    FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);

    vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
    clear FV2;
    clear FV3;
    Options.Alpha = Options.Alpha + 0.01;
end

experiment_dest_folder = '/home/manuel/Tesis/expDeA01/Beta/';
mkdir(strcat(experiment_dest_folder));
Options.Wedge=0;
Options.Wline=0;
Options.Alpha=0;
Options.Beta=0.1;
Options.Kappa=2;
Options.Delta=0;
while Options.Beta < 0.5
    params = strcat(num2str(Options.Iterations),',', num2str(Options.Wedge),',', num2str(Options.Alpha), ',',num2str(Options.Beta), ',', num2str(Options.Delta));                    
    FV2 = CustomSnake3D(prob_matrix_cell{3},FV,Options);                    

    FV3 = FV2;
    FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);

    vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
    clear FV2;
    clear FV3;
    Options.Beta = Options.Beta + 0.1;
end

experiment_dest_folder = '/home/manuel/Tesis/exp4/Delta/';
mkdir(strcat(experiment_dest_folder));
Options.Beta=0;
while Options.Delta < 0.05
    params = strcat(num2str(Options.Iterations),',', num2str(Options.Wedge),',', num2str(Options.Alpha), ',',num2str(Options.Beta), ',', num2str(Options.Delta));                    
    FV2 = CustomSnake3D(prob_matrix_cell{3},FV,Options);                    

    FV3 = FV2;
    FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);

    vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
    clear FV2;
    clear FV3;
    Options.Delta = Options.Delta + 0.01;
end

experiment_dest_folder = '/home/manuel/Tesis/exp4/Wedge/';
mkdir(strcat(experiment_dest_folder));
Options.Delta=0;
while Options.Wedge < 0.05
    params = strcat(num2str(Options.Iterations),',', num2str(Options.Wedge),',', num2str(Options.Alpha), ',',num2str(Options.Beta), ',', num2str(Options.Delta));                    
    FV2 = CustomSnake3D(prob_matrix_cell{3},FV,Options);                    

    FV3 = FV2;
    FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);

    vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
    clear FV2;
    clear FV3;
    Options.Wedge = Options.Wedge + 0.01;
end

experiment_dest_folder = '/home/manuel/Tesis/expDeA00001/Wline/';
mkdir(strcat(experiment_dest_folder));
Options.Wedge=0;
Options.Wline=-0.0001;
Options.Alpha=0;
Options.Beta=0;
Options.Kappa=2;
Options.Delta=0; 
while Options.Wline > -0.0005
    params = strcat(num2str(Options.Iterations),',', num2str(Options.Wedge),',', num2str(Options.Alpha), ',',num2str(Options.Beta), ',', num2str(Options.Delta), ',', num2str(Options.Wline));                    
    FV2 = CustomSnake3D(prob_matrix_cell{3},FV,Options);                    

    FV3 = FV2;
    FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);

    vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
    clear FV2;
    clear FV3;
    Options.Wline = Options.Wline - 0.0001;
end
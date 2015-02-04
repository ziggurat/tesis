dest_folder = '/home/manuel/Tesis/nuevoSnake/';
%mkdir(strcat(dest_folder));

Options=struct;
% con 0.04 ya redondea bastante
Options.A=0.01;
% con 0.04 ya redondea bastante
Options.B=0.01;
%en 0.1 se despelota mal, anda mas o menos bien con 0.004
Options.C=0.004;
% con 0.5 empeora, con 0.04 casi no modifica
Options.D=0.1;
% Entre 3 y 5 no cambia nada
Options.K=4;
Options.Gamma=1;
Options.Iterations=60;
%no puede ser 0
Options.Sigma1=2;
%no puede ser 0
Options.Sigma2=2;
% FV = struct;
% FV.vertices = mesh_nodes{1};
% FV.faces = mesh_faces{1};
% I=prob_matrix_cell{1};

experiment_dest_folder = strcat(dest_folder,'expAnidados/');
mkdir(strcat(experiment_dest_folder));
while Options.A <= 0.03
    while Options.B <=0.03
        while Options.C <=0.005
            while Options.D <= 0.4
                params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
                FV2 = NuevoCustomSnake3D(I,FV,Options);                    

                FV3 = FV2;
                FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);

                vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
                clear FV2;
                clear FV3;
                Options.D = Options.D + 0.1;
            end
            Options.D = 0.1; 
            Options.C = Options.C + 0.001;
        end
        Options.C = 0.004;
        Options.B = Options.B + 0.005;
    end
    Options.B = 0.01;
    Options.A = Options.A + 0.005;
end


% experiment_dest_folder = strcat(dest_folder,'expDeIt/');
% mkdir(strcat(experiment_dest_folder));
% while Options.Iterations <= 120
%     params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
%     FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
%     FV3 = FV2;
%     FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
%     vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
%     clear FV2;
%     clear FV3;
%     Options.Iterations = Options.Iterations + 20;
% end

% experiment_dest_folder = strcat(dest_folder,'expDeGamma/');
% %mkdir(strcat(experiment_dest_folder));
% %Options.Gamma=3.5;
% while Options.Gamma <= 1.2
%     params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
%     FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
%     FV3 = FV2;
%     FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
%     vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
%     clear FV2;
%     clear FV3;
%     Options.Gamma = Options.Gamma + 0.1;
% end

% experiment_dest_folder = strcat(dest_folder,'expDeA/');
% % mkdir(strcat(experiment_dest_folder));
% Options.D=0;
% Options.A=0.5;
% while Options.A <= 2
%     params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
%     FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
%     FV3 = FV2;
%     FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
%     vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
%     clear FV2;
%     clear FV3;
%     Options.A = Options.A + 0.5;
% end
% 
% experiment_dest_folder = strcat(dest_folder,'expDeB/');
% mkdir(strcat(experiment_dest_folder));
% Options.A=0;
% Options.B=0.5;
% while Options.B <= 2
%     params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                                  
%     FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
%     FV3 = FV2;
%     FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
%     vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
%     clear FV2;
%     clear FV3;
%     Options.B = Options.B + 0.5;
% end
% 
% experiment_dest_folder = strcat(dest_folder,'expDeC/');
% % mkdir(strcat(experiment_dest_folder));
% Options.B=0;
% Options.C=0.1;
% while Options.C <= 0.5
%     params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                                  
%     FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
%     FV3 = FV2;
%     FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
%     vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
%     clear FV2;
%     clear FV3;
%     Options.C = Options.C + 0.1;
% end
% 
% experiment_dest_folder = strcat(dest_folder,'expDeD/');
% mkdir(strcat(experiment_dest_folder));
% Options.D=0.5;
% while Options.D <= 0.2
%     params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                                  
%     FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
%     FV3 = FV2;
%     FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
%     vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
%     clear FV2;
%     clear FV3;
%     Options.D = Options.D + 0.02;
% end
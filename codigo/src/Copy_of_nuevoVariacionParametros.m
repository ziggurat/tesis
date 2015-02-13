dest_folder = '/home/manuel/Tesis/masTeValeQueAndes/snakeConSigmayMu/';
%mkdir(strcat(dest_folder));


%Falta con 0.01 de K, para valores int desde 0.01
% ArregloK = [0.01,0.06,0.1];
% Options.K = 0.01;
% ArregloInt = [0.01,0.015,0.03];
% ArregloC = [0.008,0.02,0.05,0.1];
% ArregloD = [0.02,0.06,0.09,0.3,0.8,1,3];

%probar con d en funcion de c, xej, c*100

ArregloK = [0.01];
ArregloInt = [0.5];
ArregloC = [0.015];
ArregloD = [100];

%Options.K=2;
Options.Gamma=1;
%no puede ser 0
Options.Sigma1=2;
%no puede ser 0
Options.Sigma2=1;
Options.Iterations=50;

experiment_dest_folder = strcat(dest_folder,'estudio/internas/');
mkdir(strcat(experiment_dest_folder));

 for k=1:numel(ArregloK)
    Options.K = ArregloK(k);
    for int=1:numel(ArregloInt)
        Options.A = ArregloInt(int);
        Options.B = ArregloInt(int);
        for c=1:numel(ArregloC)
            Options.C = ArregloC(c);
            for d=1:numel(ArregloD)
                Options.D = ArregloC(c)*ArregloD(d);
                params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
                
                Options.params = params;
                FV2 = NuevoCustomSnake3D(I,FV,Options);                    

                FV3 = FV2;
                FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);

                vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,params, '.obj'));    
                clear FV2;
                clear FV3;
            end
        end
    end
end


% ArregloInt = [0.015];
% Options.C = 0.003;
% Options.D = 0.2;
% Options.K = 0.001;
% 
% for int=1:numel(ArregloInt)
%     Options.A = ArregloInt(int);
%     Options.B = ArregloInt(int);
%     
%     params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
%     FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
%     FV3 = FV2;
%     FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
%     vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,params, '.obj'));    
%     clear FV2;
%     clear FV3;
% end

% Options.A = 0.05;
% Options.B = 0.05;
% Options.C = 0.05;
% Options.D = 0.05;
% 
% params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
% FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
% FV3 = FV2;
% FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
% vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,params, '.obj'));    
% clear FV2;
% clear FV3;
% 
% Options.A = 0.005;
% Options.B = 0.005;
% Options.C = 0.01;
% Options.D = 0.01;
% 
% params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
% FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
% FV3 = FV2;
% FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
% vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,params, '.obj'));    
% clear FV2;
% clear FV3;
% 
% Options.A = 0.05;
% Options.B = 0.05;
% Options.C = 0.1;
% Options.D = 0.1;
% 
% params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
% FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
% FV3 = FV2;
% FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
% vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,params, '.obj'));    
% clear FV2;
% clear FV3;

% Options.A = 1;
% Options.B = 1;
% Options.C = 0.8;
% Options.D = 2;
% Options.K = 0.2;
% 
% params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
% FV2 = NuevoCustomSnake3D(I,FV,Options);                    
% 
% FV3 = FV2;
% FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);
% 
% vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,params, '.obj'));    
% clear FV2;
% clear FV3;





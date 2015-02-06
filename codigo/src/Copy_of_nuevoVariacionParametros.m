dest_folder = '/home/manuel/Tesis/masTeValeQueAndes/snakeConSigmayMu/';
%mkdir(strcat(dest_folder));

ArregloK = [0.001,0.005,0.01,0.02];
ArregloInt = [0.02,0.05,0.08,0.1];
ArregloC = [0.02,0.05,0,08,0.1];
ArregloD = [0.1,0.5];

%Options.K=2;
Options.Gamma=1;
%no puede ser 0
Options.Sigma1=2;
%no puede ser 0
Options.Sigma2=2;
Options.Iterations=100;

experiment_dest_folder = strcat(dest_folder,'conArreglo/');
Options.destFolder = experiment_dest_folder;
mkdir(strcat(experiment_dest_folder));

for k=1:numel(ArregloK)
    Options.K = ArregloK(k);
    for int=1:numel(ArregloInt)
        Options.A = ArregloInt(int);
        Options.B = ArregloInt(int);
        for c=1:numel(ArregloC)
            Options.C = ArregloC(c);
            for d=1:numel(ArregloD)
                Options.D = ArregloD(d);
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


% Options.A = 0.1;
% Options.B = 0.1;
% Options.C = 0.1;
% Options.D = 1;
% Options.K = 0.005;
% Options.Iterations = 100;
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





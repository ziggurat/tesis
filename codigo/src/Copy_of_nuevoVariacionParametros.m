dest_folder = '/home/manuel/Tesis/nuevoSnake/';
%mkdir(strcat(dest_folder));

Arreglo = [0.0001,0.0005,0.001,0.005,0.01,0.05,0.1,0.5];

Options=struct;
% Entre 3 y 5 no cambia nada
Options.K=4;
Options.Gamma=1;
Options.Iterations=60;
%no puede ser 0
Options.Sigma1=2;
%no puede ser 0
Options.Sigma2=2;

experiment_dest_folder = strcat(dest_folder,'expConArreglo/');
mkdir(strcat(experiment_dest_folder));
for a=1:numel(Arreglo)
    Options.A = Arreglo(a);
    for b=1:numel(Arreglo)
        Options.B = Arreglo(b);
        for c=1:numel(Arreglo)
            Options.C = Arreglo(c);
            for d=1:numel(Arreglo)
                Options.D = Arreglo(d);
                params = strcat('it',num2str(Options.Iterations),',A',num2str(Options.A),',B',num2str(Options.B),',C',num2str(Options.C),',D',num2str(Options.D),',K',num2str(Options.K),',G',num2str(Options.Gamma));                    
                FV2 = NuevoCustomSnake3D(I,FV,Options);                    

                FV3 = FV2;
                FV3.vertices = trasladarEinvertir(FV2.vertices, nii.hdr.dime.pixdim);

                vertface2obj(FV3.vertices, FV3.faces, strcat(experiment_dest_folder,'snakes_', num2str(2),'_',params, '.obj'));    
                clear FV2;
                clear FV3;
            end
        end
    end
end


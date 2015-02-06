function FV=NuevoCustomSnake3D(I,FV,Options)
% This function SNAKE implements the basic snake segmentation. A snake is an 
% active (moving) contour, in which the points are attracted by edges and
% other boundaries. To keep the contour smooth, an membrame and thin plate
% energy is used as regularization.
%
% OV=Snake3D(I,FV,Options)
%  
% inputs,
%   I : An Image of type double preferable ranged [0..1]
%   FV : Structure with triangulated mesh, with list of faces FV.faces N x 3
%        and list of vertices M x 3
%   Options : A struct with all snake options
%   
% outputs,
%   FV : Structure with triangulated mesh of the final surface
%
% options 
%  Options.Gamma : Time step, default 1
%  Options.Iterations : Number of iterations, default 100
%  Options.A : peso de derivada de primer orden - fuerza interna
%  Options.B : peso de derivada de segundo orden - fuerza interna
%  Options.C : peso de la fuerza de inflacion
%  Options.D : peso de la fuerza de gradiente
%  Options.K : diferencia respecto al desvio que tolera mi funcion
%  Options.Sigma1 : para Gaussiano de la imagen, para fuerza de gradiente
%  (default 2?)
%  Options.Sigma2 : para convertir la energia en fuerza (probar default 1)
%
%
% Example,
%
% load testvolume
% load SphereMesh
% Options=struct;
% FV.vertices(:,1)=FV.vertices(:,1)+35;
% FV.vertices(:,2)=FV.vertices(:,2)+25;
% FV.vertices(:,3)=FV.vertices(:,3)+20;
% OV=Snake3D(I,FV,Options)

% Process inputs
% I = I * double(255); %% Esto es para multiplicar la matriz de
% probabilidades.
defaultoptions=struct('Verbose',false,'Sigma1',2,'Sigma2',2,'A',0.2,'B',0.2, 'C',0.0001,'D',3,'Gamma',0.8,'K',4,'Iterations',100);
if(~exist('Options','var')), 
    Options=defaultoptions; 
else
    tags = fieldnames(defaultoptions);
    for i=1:length(tags)
         if(~isfield(Options,tags{i})), Options.(tags{i})=defaultoptions.(tags{i}); end
    end
    if(length(tags)~=length(fieldnames(Options))), 
        warning('snake:unknownoption','unknown options found');
    end
end

% Convert input to single if xintxx
if(~strcmpi(class(I),'single')&&~strcmpi(class(I),'double'))
    I=single(I);
end

% The surface faces must always be clockwise (because of the balloon force)
FV=MakeContourClockwise3D(FV);

% Calculo media (mu) y desvio estandar (sigma) para cada voxel de la imagen
mu=imfilter(I, fspecial3('average',[3 3 3]));
sigma=stdfilt(I, ones(3,3,3));
sigma(sigma==0)=1;

%Einf = ones(size(I)) * -1;
%Einf (( I - imfilter(I, fspecial3('average',[3 3 3])) ) < ( Options.K * stdfilt(I, ones(3,3,3)) )) = 1;

% Calculo energia de gradiente
Egrad = EnergiaGradiente(I,Options.Sigma1);

% Calculo fuerza de gradiente para cada coordenada en funcion de Egrad
Fx=ImageDerivatives3D(Egrad,Options.Sigma2,'x');
Fy=ImageDerivatives3D(Egrad,Options.Sigma2,'y');
Fz=ImageDerivatives3D(Egrad,Options.Sigma2,'z');

Fgrad(:,:,:,1)=-Fx*2*Options.Sigma2^2;
Fgrad(:,:,:,2)=-Fy*2*Options.Sigma2^2;
Fgrad(:,:,:,3)=-Fz*2*Options.Sigma2^2;

% ACA IBA VERBOSE
% Show the image, contour and force field
if(Options.Verbose)
     drawnow; pause(0.1);
     h=figure; set(h,'render','opengl'); hold on;
     %patch(i,'facecolor',[1 0 0],'facealpha',0.1);
     ind=find(I(:)>0);
     [ix,iy,iz]=ind2sub(size(Fgrad),ind);
     plot3(ix,iy,iz,'b.');
     hold on;
     h=patch(FV,'facecolor',[1 0 0],'facealpha',0.1);
     drawnow; pause(0.1);
end


fprintf('Starting iterations...\n');
tic

%Variables para ver convergencia
Vant = zeros(size(FV.vertices));
averageDisplacement = zeros(Options.Iterations,1);

i = 1;
despAnt = Inf;
despAct = 0;
while ((i < Options.Iterations) && (abs(despAnt - despAct) > 0.001))
    
	despAnt = despAct;

%for i=1:Options.Iterations
    
    % Re calculo fuerza de inflacion
    % fprintf('Start internal force matrix re calculation...\n');
    % tic
    Fint=CustomSnakeInternalForceMatrix3D(FV,Options.A,Options.B,Options.Gamma);
    % fprintf('Finished internal force matrix...\n');
    
    FV=NuevoCustomSnakeMoveIteration3D(I,FV,Fint,Fgrad,Options.mu,Options.sigma,Options.Gamma,Options.C,Options.D,Options.K);
    fprintf('.');    
    
    % ACA IBA VERBOSE
    % Show current contour
    if(Options.Verbose)
        if(ishandle(h));
            delete(h);
            h=patch(FV,'facecolor',[1 0 0],'facealpha',0.1);
            drawnow; %pause(0.1);
        end
    end
    
    %Calculo diferencia, para convergencia
    Diff = FV.vertices - Vant;
    averageDisplacement(i) = mean(sqrt(sum(abs(Diff).^2,2)));    
    despAct = averageDisplacement(i);
    disp(averageDisplacement(i));
    %Guardo los nuevos vertices como anteriores
    Vant = FV.vertices;
    i = i + 1;
    
end
%save(strcat(Options.destFolder, Options.params, '.txt'), 'averageDisplacement');
%Esto me dibuja el grafico de convergencia
%figure, loglog(averageDisplacement);

fprintf('\n');
fprintf('Finished iterations...\n');
toc



function FV=NuevoCustomSnakeMoveIteration3D(I,FV,Fint,Fgrad,mu,sigma,gamma,c,d,k)
% This function will calculate one iteration of contour Snake movement
%
% inputs,
%   FV : The triangulated surface
%   Fint : Fuerza interna
%   Fgrad : Fuerza de gradiente
%   mu: media de la imagen
%   sigma: desviacion estandar de la imagen
%   gamma : Time step
%   c : peso de fuerza de inflacion
%   d : peso de fuerza de gradiente
%   k : variable para calcular fuerza de inflacion
%
% outputs,
%   FV : The (moved) contour points N x 2;

V=FV.vertices;

% Clamp contour to boundary
% V(:,1)=min(max(V(:,1),1),size(Fgrad,1));
% V(:,2)=min(max(V(:,2),1),size(Fgrad,2));
% V(:,3)=min(max(V(:,3),1),size(Fgrad,3));

% Aplico la fuerza de gradiente a cada vertice
Fext1(:,1)=interp3(Fgrad(:,:,:,1),V(:,2),V(:,1),V(:,3));
Fext1(:,2)=interp3(Fgrad(:,:,:,2),V(:,2),V(:,1),V(:,3));
Fext1(:,3)=interp3(Fgrad(:,:,:,3),V(:,2),V(:,1),V(:,3));

% Interp3, can give nan's if contour close to border
Fext1(isnan(Fext1))=0;

% Calculo las normales para definir la fuerza en cada vertice
N=PatchNormals3D(FV);

% Fuerza de gradiente, but only the component in the  direction of 
% the surface normal
Fext3=repmat(dot(Fext1,N,2),1,3).*N;

% Calculo fuerza de inflacion
IV = interp3(I, V(:,2), V(:,1), V(:,3));
IV(isnan(IV))=0;

% muV= interp3(mu, V(:,2), V(:,1), V(:,3));
% muV(isnan(muV))=0;
% 
% sigmaV= interp3(sigma, V(:,2), V(:,1), V(:,3));
% sigmaV(isnan(sigmaV))=0;


Einf = ones(size(IV)) * -1;
Einf(abs(IV - mu)<= (k*sigma))=1;

%Einf (( I - imfilter(I, fspecial3('average',[3 3 3])) ) < ( Options.K * stdfilt(I, ones(3,3,3)) )) = 1;
% inflar=(IV - muV)<= (k*sigmaV);
% IV(inflar)=1;
% IV(1-inflar)=-1;

% Finf_ = interp3(Einf, V(:,2), V(:,1), V(:,3));
Finf_ = cat(2, Einf, Einf, Einf);
% 
Finf = N .* Finf_;

%Calculo la nueva posicion de los vertices
V(:,1) = Fint \ (gamma * V(:,1) - c * Finf(:,1) - d * Fext3(:,1)); 
V(:,2) = Fint \ (gamma * V(:,2) - c * Finf(:,2) - d * Fext3(:,2));
V(:,3) = Fint \ (gamma * V(:,3) - c * Finf(:,3) - d * Fext3(:,3));

% V(:,1) = V(:,1) - gamma*(Ften(:,1)+Fflex(:,1)- c*Finf(:,1)- d * Fext3(:,1)); 
% V(:,2) = V(:,2) - gamma*(Ften(:,2)+Fflex(:,2)- c*Finf(:,2) - d * Fext3(:,2));
% V(:,1) = V(:,3) - gamma*(Ften(:,3)+Fflex(:,3)- c * Finf(:,3) - d * Fext3(:,3)); 


% Clamp contour to boundary
% V(:,1)=min(max(V(:,1),1),size(Fgrad,1));
% V(:,2)=min(max(V(:,2),1),size(Fgrad,2));
% V(:,3)=min(max(V(:,3),1),size(Fgrad,3));
    
FV.vertices=V;
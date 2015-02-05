function Egrad = EnergiaGradiente(I,Sigma)
% Eextern = ExternalForceImage3D(I,Wline, Wedge,Sigma)
% 
% inputs, 
%  I : The image
%  Sigma : Sigma used to calculated image derivatives 
%  D : peso para fuerza de gradiente
% outputs,
%  Eextern : Fuerza de gradiente


Ix=ImageDerivatives3D(I,Sigma,'x');
Iy=ImageDerivatives3D(I,Sigma,'y');
Iz=ImageDerivatives3D(I,Sigma,'z');

% Eedge = sqrt(Ix.^2 + Iy.^2 + Iz.^2); % 
% Egrad= -D * Eedge;

Egrad=sqrt(Ix.^2 + Iy.^2 + Iz.^2);

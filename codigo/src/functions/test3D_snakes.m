%clear;
%load('c:\Users\Manuel\fcm.mat');

Options=struct;
Options.Verbose=0;
Options.Wedge=0;
Options.Wline=-1;
Options.Alpha=0.1;
Options.Beta=0.1;
Options.Kappa=0;
Options.Delta=0.2;
Options.Gamma=1;
Options.Iterations=15;
Options.Sigma1=2;
Options.Sigma2=2;
Options.Lambda=0.8;
FV = struct;
FV.vertices = newnode{1};
clean_face = newface{1};
%clean_face(:,1) = [];
FV.faces = clean_face;
FV2=Snake3D(double(original),FV,Options);
vertface2obj(FV2.vertices, FV2.faces, strcat('c:\Users\Manuel\snake', num2str(1), '0.1.obj'));
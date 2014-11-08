load testvolume
load SphereMesh
Options=struct;
Options.Verbose=1;
Options.Wedge=0;
Options.Wline=-1;
Options.Alpha=0.0000000001;
Options.Beta=0.1;
Options.Kappa=0.5;
Options.Delta=0.11;
Options.Gamma=0.035;
Options.Iterations=20;
Options.Sigma1=2;
Options.Sigma2=2;
Options.Lambda=0.8;
FV.vertices(:,1)=FV.vertices(:,1)+35;
FV.vertices(:,2)=FV.vertices(:,2)+25;
FV.vertices(:,3)=FV.vertices(:,3)+20;
OV=Snake3D(I,FV,Options)
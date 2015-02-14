%load testvolume;
load SphereMesh;
Options=struct;
Options.Verbose = false;
Options.A=0.01;
Options.B=0.01;
Options.C=0.004;
Options.D=0.1;
Options.K=3;
Options.Sigma1=2;
Options.Sigma2=2;
Options.Gamma=0.1;
Options.Iterations=50;
% I=prob_matrix_cell{1};
% FV = struct;
% FV.vertices = mesh_nodes{1};
% FV.faces = mesh_faces{1};
% OV=NuevoCustomSnake3D(I,FV,Options);


%OV=NuevoCustomSnake3D(I,FV,Options);
%RV = OV;
%RV.vertices = trasladarEinvertir(OV.vertices, nii.hdr.dime.pixdim);
%vertface2obj(RV.vertices, RV.faces, 'aver.obj');

% FV2 = FV;
% FV2.vertices = FV.vertices * 0.9;
% 
chile = 0.1;
% tic
p0 = createRayGrid(-5,5,6, chile);
% toc
%[t0,u0,v0,idx0]=customRaySurf(p0, [-1,0,0], FV.vertices, FV.faces, chile);
%tic
vol=meshVolumeDiff(p0, [0,0,-1], FV.vertices, FV.faces, FV.vertices, FV.faces, chile);
%toc
% 

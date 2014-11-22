%load SphereMesh;
%load testvolume;
%ind=find(I(:)>0);
%[ix,iy,iz]=ind2sub(3,ind);
%plot3(ix,iy,iz,'b.');
%hold on;
%h=patch(FV,'facecolor',[1 0 0],'facealpha',0.1);
[node,elem,face]=v2m(cluster_images{3},0.5,5,100);
h=plotsurf(node,face);

drawMesh(FV.vertices, FV.faces);
hold on;
vb = boundingBox3d(FV.vertices)
drawBox3d(vb);
vol = meshVolume(FV.vertices, FV.faces);

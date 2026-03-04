function initPosePlot(ax, mapMatrix, initX, initY, initTheta)
show(binaryOccupancyMap(mapMatrix),"Parent",ax);
plotTransforms([initX,initY,0],eul2quat([initTheta,0,0]),"MeshFilePath","groundvehicle.stl","View","2D");
light;
end


function posePlot(pose, ax)
persistent previousPosition
if isempty(previousPosition)
    previousPosition = pose(1:2);
end

hold(ax, "on");
plotTransforms([pose(1), pose(2), 0], eul2quat([pose(3), 0, 0]), "MeshFilePath", "groundvehicle.stl", "View", "2D", "Parent", ax);
trace = vertcat(previousPosition, pose(1:2));
line(ax, trace(:,1), trace(:,2), 'Color','red', 'Marker', '--');
hold(ax, "off");
end


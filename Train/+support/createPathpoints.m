function [points, angles, speeds] = createPathpoints(waypoints, expectedLinSpeed, sampleTime)
% waypoints: Matrix of n x 2, having the waypoints the path will pass
% through in (x,y) coordinates.
% expectedLinSpeed: trajectory linear speed
% sampleTime: The number of meters between each point.
samplingRate = expectedLinSpeed * sampleTime;
numWaypoints = size(waypoints, 1);

waypointAngles = zeros(numWaypoints,1);
for waypoint = 1:(numWaypoints-1)
    pointA = waypoints(waypoint,:);
    pointB = waypoints(waypoint+1,:);
    distance = pointB-pointA;
    waypointAngles(waypoint) = atan2(distance(2), distance(1));
end
waypointAngles = unwrap(waypointAngles);

points = [];
angles = [];
linSpeed = [];
angSpeed = [];

for waypoint = 1:(numWaypoints-1)
    pointA = waypoints(waypoint,:);
    pointB = waypoints(waypoint+1,:);
    %distanceX = pointB(1) - pointA(1);
    %distanceY = pointB(2) - pointA(2);
    distance = norm(pointB-pointA);

    numSamples = ceil(distance/samplingRate);
    vertexPointsX = linspace(pointA(1), pointB(1), numSamples);
    vertexPointsY = linspace(pointA(2), pointB(2), numSamples);

    vertexPointsX(end) = []; % Don't consider the last point on the path, as it's the first point of the following path.
    vertexPointsY(end) = [];

    vertexPoints = horzcat(vertexPointsX', vertexPointsY');
    vertexSize = size(vertexPoints,1);

    vertexAngles = repelem(waypointAngles(waypoint),vertexSize);
    
    vertexAngSpeeds = zeros(vertexSize,1);
    vertexAngSpeeds(1) = (waypointAngles(waypoint) - waypointAngles(waypoint+1)) / samplingRate; % samplingtimeeee

    if isempty(points)
        points = vertexPoints;
        angles = vertexAngles;
        angSpeed = vertexAngSpeeds;
    else
        points = vertcat(points, vertexPoints);
        angles = horzcat(angles, vertexAngles);
        angSpeed = vertcat(angSpeed, vertexAngSpeeds);
    end
end
points = vertcat(points, [waypoints(end,1)  waypoints(end,2)]);
angles(end+1) = angles(end);
angSpeed(1) = 0;
angSpeed(end+1) = 0;
linSpeed = [0 repelem(expectedLinSpeed,size(points,1)-1)];
display(linSpeed);

speeds = [linSpeed.' angSpeed];

end
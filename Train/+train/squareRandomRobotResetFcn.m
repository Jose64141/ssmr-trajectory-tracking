function in = squareRandomRobotResetFcn(in)
sampleTime = evalin('base','sampleTime');
expectedLinSpeed = evalin('base','expectedLinSpeed');
waypoints = evalin('base','waypoints');

scaleFactor = (2*randi([0 1])-1)*0.1*rand();


randomWaypointFactor = [
    -1*scaleFactor -1*scaleFactor;
    -1*scaleFactor scaleFactor;
    scaleFactor scaleFactor;
    scaleFactor -1*scaleFactor;
    -1*scaleFactor -1*scaleFactor;
];
 
[pathpoints, angles, speeds] = support.createPathpoints(randomWaypointFactor+waypoints, expectedLinSpeed, sampleTime);

assignin('base', 'pathpoints', pathpoints);
assignin('base', 'angles', angles);
assignin('base', 'speeds', speeds);

%in = setBlockParameter(in,"pathFollowingRobot/Environment/Constant","Value", pathpoints);
%in = setBlockParameter(in,"pathFollowingRobot/Environment/Constant2","Value", speeds);
end
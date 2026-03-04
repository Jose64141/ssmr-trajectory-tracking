function [error, errorNorm, directionError, linSpeedError, angSpeedError, isDone, reference, nextReference] = computeProgress(pose, dot, speeds, time, pathpoints, angles, sampleTime)
persistent lastRobotPosition
persistent lastReference
persistent isInit
numPathpoints = size(pathpoints, 1);
if isempty(lastRobotPosition)
    lastRobotPosition = [0 0];
    lastReference = [0 0];
    isInit = false;
end
robotPosition = pose';

index = int32(time/sampleTime + 1); %Index 1 is for instant 0[s] 

reference = zeros(1,3);
reference(1:2) = pathpoints(index,:);
reference(3) = angles(index);
speedReference = speeds(index,:);
nextReference = zeros(1,3);
if index+1 <= numPathpoints
    nextReference(1:2) = pathpoints(index+1,:);
else
    nextReference = reference;
end
error = [0 0];
error(1) = reference(1) - robotPosition(1);
error(2) = reference(2) - robotPosition(2);
errorNorm = norm(error);


nextReferencePositionDelta = nextReference(1:2) - robotPosition(1:2);

robotDirection = robotPosition(3); 
referenceDirection = reference(3); 
directionError = wrapToPi(referenceDirection - robotDirection);
nextReference(3) = atan2(nextReferencePositionDelta(2),nextReferencePositionDelta(1)); % nextReferenceDirection

lastRobotPosition = robotPosition(1:2);
lastReference = reference(1:2);

linSpeedError = speedReference(1) - dot(1);
angSpeedError = speedReference(2) - dot(2);

error = error';
reference = reference';
nextReference = nextReference';
isDone = index == numPathpoints;
if ~isInit
    isInit = true;
    directionError = 0;
end
end
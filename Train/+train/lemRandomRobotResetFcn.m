function in = lemRandomRobotResetFcn(in)
persistent noise
if isempty(noise)
    noise = 0;
end

sampleTime = evalin('base','sampleTime');

[pathpoints, angles, speeds] = support.createLemniscateTrajectory( ...
    0.075 * (1+(2*randi([0 1])-1)*0.1*rand()),...
    sampleTime,...
    [10 10] + (2*randi([0 1])-1)*0.5*rand(1,2),...
    5 + (2*randi([0 1])-1)*0.25*rand()...
    );

assignin('base', 'pathpoints', pathpoints);
assignin('base', 'angles', angles);
assignin('base', 'speeds', speeds);

if round(noise) <= 2*pi/3%pi/4
    noise = noise + ((2*pi/36)/100) * rand(); % aproximate (expected) increment of 5 degree in 100 episodes
end

initPose = evalin('base','initPose');
initPose(3) = (2*randi([0 1])-1) * (initPose(3) + noise);
assignin('base', 'initPose', initPose);

%in = setBlockParameter(in,"pathFollowingRobot/Environment/Constant","Value", pathpoints);
%in = setBlockParameter(in,"pathFollowingRobot/Environment/Constant2","Value", speeds);
end
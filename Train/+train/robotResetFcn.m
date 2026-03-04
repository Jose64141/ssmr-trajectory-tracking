function in = robotResetFcn(in)
initPose = evalin('base','initPose');
in = setVariable(in,"initX", initPose(1));
in = setVariable(in,"initY", initPose(2));
in = setVariable(in,"initTheta",initPose(3));% 0.507);% 1.249);% pi/4 (for tilted path)
end
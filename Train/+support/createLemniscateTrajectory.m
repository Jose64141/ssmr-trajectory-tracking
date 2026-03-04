function [pathpoints, angles, speeds] = createLemniscateTrajectory(phiSpeed, sampleTime, center, scale)
    phases = -pi : phiSpeed*sampleTime : pi;

    pointsX = scale*cos(phases) + center(1);
    pointsY = scale*(cos(phases).*sin(phases)) + center(2);
    pathpoints = horzcat(pointsX', pointsY');
    angles = unwrap(atan2(cos(2*phases), -sin(phases)));

    speeds = zeros(numel(phases),2);
    for i = 2:numel(phases)
        displacementX = pointsX(i) - pointsX(i-1);
        displacementY = pointsY(i) - pointsY(i-1);
        displacement = [displacementX displacementY];
        linSpeed = norm(displacement) / sampleTime;
        angSpeed = (angles(i) - angles(i-1)) / sampleTime;
        speeds(i,:) = [linSpeed angSpeed];
    end
end
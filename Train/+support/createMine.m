function [points, angles, speeds] = createMine(waypoints, Ts, vMin, vMax, wMin, wMax)
    % Inputs:
    %   waypoints - N x 2 matrix [x, y] of waypoints
    %   Ts        - Sample time (seconds)
    %   vMin      - Minimum linear speed (m/s)
    %   vMax      - Maximum linear speed (m/s)
    %   wMin      - Minimum angular speed (rad/s)
    %   wMax      - Maximum angular speed (rad/s)
    % Outputs:
    %   trajX, trajY  - X and Y coordinates of the smoothed trajectory
    %   trajTheta     - Orientation (theta) of the trajectory
    %   trajV         - Linear speed profile
    %   trajW         - Angular speed profile
    %   time          - Time vector

    % Use cscvn (cubic spline curve with variable nodes) for smooth trajectory
    pp = cscvn(waypoints');

    % Generate a fine sampling of the spline curve
    tSamples = linspace(pp.breaks(1), pp.breaks(end), 1000);
    trajPoints = fnval(pp, tSamples);
    trajX = trajPoints(1, :);
    trajY = trajPoints(2, :);

    % Calculate derivatives for orientation and velocity
    dx = gradient(trajX, Ts);
    dy = gradient(trajY, Ts);
    trajTheta = atan2(dy, dx);

    % Compute arc length for time parameterization
    arcLength = [0, cumsum(sqrt(diff(trajX).^2 + diff(trajY).^2))];
    totalDistance = arcLength(end);
    avgSpeed = (vMin + vMax) / 2;
    totalTime = totalDistance / avgSpeed;
    time = 0:Ts:totalTime;

    % Interpolate trajectory for uniform sampling
    trajX = interp1(arcLength, trajX, linspace(0, totalDistance, length(time)));
    trajY = interp1(arcLength, trajY, linspace(0, totalDistance, length(time)));
    trajTheta = interp1(arcLength, trajTheta, linspace(0, totalDistance, length(time)));

    % Recompute velocities
    dx = gradient(trajX, Ts);
    dy = gradient(trajY, Ts);
    ddx = gradient(dx, Ts);
    ddy = gradient(dy, Ts);

    trajV = min(max(sqrt(dx.^2 + dy.^2), vMin), vMax);
    trajW = min(max((ddy .* dx - ddx .* dy) ./ (dx.^2 + dy.^2), wMin), wMax);
    
    points = vertcat(trajX,trajY).';
    angles = trajTheta;
    angSpeed = trajW.';
    linSpeed = trajV.';
    
    speeds = [linSpeed angSpeed];
end

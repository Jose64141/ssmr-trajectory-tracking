function [mainWaypoints, altInitialConditions] = createTestbedWaypoints(center, radius)
    mainWaypoints = zeros([16 5]); % InitTheta, InitX, InitY, EndX, EndY
    altInitialConditions = zeros([16 9]); % AltAngle1, AltAngle2, AltInitTheta1, AltInitX1, AltInitY1, AltInitTheta2, AltInitX2, AltInitY2
    
    % Corners
    firstCorner = [...
        pi/4 ...
        center(1) center(2)... 
        (center(1) + radius) (center(2) + radius)...
        ];
    mainWaypoints(1,:) = firstCorner;
    altInitialConditions(1,:) = createAltInitialConditions(pi/4, center, radius); 
    
    secondCorner = [...
        3*pi/4 ...
        center(1) center(2)...
        (center(1) - radius) (center(2) + radius)...
        ];
    mainWaypoints(2,:) = secondCorner;
    altInitialConditions(2,:) = createAltInitialConditions(3*pi/4, center, radius); 
    
    thirdCorner = [
        5*pi/4 ...
        center(1) center(2)...
        (center(1) - radius) (center(2) - radius)...
        ];
    mainWaypoints(3,:) = thirdCorner;
    altInitialConditions(3,:) = createAltInitialConditions(5*pi/4, center, radius); 
    
    fourthCorner = [...
        7*pi/4 ...
        center(1) center(2)... 
        (center(1) + radius) (center(2) - radius)...
        ];
    mainWaypoints(4,:) = fourthCorner;
    altInitialConditions(1,:) = createAltInitialConditions(7*pi/4, center, radius); 


    function addWaypoints(index, angle)
        [x, y] = createCircumferenceEndpoint(center, radius, angle);
        mainWaypoints(index, :) = [angle center(1) center(2) x y];
        altInitialConditions(index, :) = createAltInitialConditions(angle, center, radius); 
    end

    index = 5;

    for angle = 0:pi/2:3*pi/2 
        
        addWaypoints(index, angle);      
        index = index + 1;

        neighborAngle = angle + pi/8;
        addWaypoints(index, neighborAngle);
        index = index + 1;
        
        neighborAngle = angle - pi/8;
        addWaypoints(index, neighborAngle);
        index = index + 1;
    end
end

function [x, y] = createCircumferenceEndpoint(center, radius, angle)
    x = center(1) + radius * cos(angle);
    y = center(2) + radius * sin(angle);
end

function initialConditions = createAltInitialConditions(initTheta, center, radius)
     % AltAngle1, AltAngle2, AltAngle3, AltInitTheta1, AltInitX1, AltInitY1, AltInitTheta2, AltInitX2, AltInitY2
    initialConditions = zeros(1,9);
    % Different initial angle
    initialConditions(1) = initTheta + pi; % AltAngle1
    initialConditions(2) = initTheta + 2*pi/3; % AltAngle2
    initialConditions(3) = initTheta + pi/4; % AltAngle2

    % Different initial point
    angle = initTheta - pi; % Opposite point in circumference
    [x, y] = createCircumferenceEndpoint(center, radius, angle);
    initialConditions(4) = initTheta; % AltInitTheta1 
    initialConditions(5) = x; % AltInitX1 
    initialConditions(6) = y; % AltInitY1 

    angle = initTheta + pi/2; % Point at 90ª in circumference
    [x, y] = createCircumferenceEndpoint(center, radius, angle);
    initialConditions(7) = - (pi - (pi/2 + initTheta) - pi/4); % AltInitTheta2 
    initialConditions(8) = x; % AltInitX2 
    initialConditions(9) = y; % AltInitY2 
    
end


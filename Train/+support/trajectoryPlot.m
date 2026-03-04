function ax = trajectoryPlot(out, pathpoints, mapMatrix)
    sampleTime = evalin('base','sampleTime');
    fig = figure("Name","simpleMap");
    set(fig, "Visible","off");
    ax = axes(fig);
    show(binaryOccupancyMap(mapMatrix),"Parent",ax);
    hold(ax,'on');
    line(ax, pathpoints(:,1), pathpoints(:,2), 'Color', 'blue', 'LineStyle', '--')
    light;
    for i = 1:size(out.referencePosition)
        pose = out.pose((mod(out.tout, sampleTime) == 0), :);
        reference = out.referencePosition;
    
        line(ax, pose(i,1), pose(i,2), 'Color', 'red', 'Marker', '.', 'MarkerSize', 3);
        line(ax, reference(i,1), reference(i,2), 'Color', 'cyan', 'Marker', '.', 'MarkerSize', 2);
        %pause(0.2);
    end
    hold(ax,'off');
end

function axisTrajectoryPlot(ax, out, pathpoints)
    sampleTime = evalin('base','sampleTime');
    hold(ax,'on');
    line(ax, pathpoints(:,1), pathpoints(:,2), 'Color', 'blue', 'LineStyle', '--')
    light;
    for i = 1:size(out.referencePosition)
        pose = out.pose((mod(out.tout, sampleTime) == 0), :);
        referencePosition = out.referencePosition;
    
        line(ax, pose(i,1), pose(i,2), 'Color', 'red', 'Marker', '.', 'MarkerSize', 3);
        line(ax, referencePosition(i,1), referencePosition(i,2), 'Color', 'cyan', 'Marker', '.', 'MarkerSize', 2);
        %pause(0.2);
    end
    hold(ax,'off');
end
function ax = limitedTrajectoryPlot(out, pathpoints, xlim, ylim)
    sampleTime = evalin('base','sampleTime');
    fig = figure("Name","Test Map");
    set(fig, "Visible","off");
    ax = axes(fig);
    ax.XLim = xlim;
    ax.YLim = ylim;
    xlabel('X Coordinates [m]');
    ylabel('Y Coordinates [m]');

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

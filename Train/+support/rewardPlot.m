function ax = rewardPlot(trainingStats)
    fig = figure("Name","Reward",'position', [0, 0, 400, 400]);
    set(fig, "Visible","off");
    ax = axes(fig);
    ax.FontSize = 10;
    
    hold(ax,'on');
    light;
    
    plot(ax, trainingStats.EpisodeReward, 'Marker', '.', 'MarkerSize', 3);
    plot(ax, trainingStats.AverageReward, 'Marker', '.', 'MarkerSize', 3);
    
    legend('Episode Reward','Average Reward', 'Location', 'southwest')
    
    xlabel('Episode number')
    ylabel('Episode reward')
    
    grid on
    hold(ax,'off'); 
    end

function PlotTrajec(Xd,q)
    figure
    set(gcf,'Name','Plot trajectory')  
    N = size(q,2);
    for i = 1:round(N/4):N
        PlotFrame(q(:,i)');
        hold on;
    end
    plot3(Xd(1,:), Xd(2,:), Xd(3,:), 'm--', 'color', 'magenta');
end


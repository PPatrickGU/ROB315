function PlotTrajec(Xd,q)
    figure
    set(gcf,'Name','Plot trajectory')
    
    N = size(q,2);
    num_sample=5;
    step_sample = round(N/num_sample);

    for i = 1:N
        if mod(i,step_sample)==1
            PlotFrame(q(:,i)');
            hold on;
        end
    end

    plot3(Xd(1,:), Xd(2,:), Xd(3,:), 'm--', 'color', 'magenta');

end


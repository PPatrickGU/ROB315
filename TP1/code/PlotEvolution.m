function PlotEvolution(q, qmin, qmax)
    figure
    set(gcf,'Name','Evolution of q')
    for i=1:6
        % Plot evolution
        subplot(3,2,i)
        plot(q(i,:), 'blue')
        hold on

        % Plot the value extremum
        plot(ones(1,length(q)).*qmax(i), '--', 'color', 'red')
        plot(ones(1,length(q)).*qmin(i), 'red')
        
        
        % Tune the y axis
        y_max = max(qmax(i), max(q(i,:)));
        y_min = min(qmin(i), min(q(i,:)));
        ylim([y_min-0.5 y_max+0.5])

        % legend and label
        grid on
        xlim([0 length(q)]);
        title(sprintf('q_{%d}',(i)));
        xlabel('time (ms)') 
        ylabel('angle (rad)')
        legend(sprintf('q_{%d}',(i)),'q_{max}', 'q_{min}');

    end
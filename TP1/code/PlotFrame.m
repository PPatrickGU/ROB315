 function PlotFrame(q)
    % Parametres
    r4 = 0.2; r1 = 0.5; rE = 0.1; 
    r = [r1 0 0 r4 0 0];
    d3 = 0.7; d = [0 0 d3 0 0 0];
    alpha = [0 pi/2 0 pi/2 -pi/2 pi/2];
    theta = q; 
    theta(3) = theta(3) + pi/2;
    
    % DGM of the robot
    [g_06, g_elem]= ComputeDGM(alpha, d, theta, r);
    g_6E = TransformMatElem(0, 0, 0, rE);
    g_0E = g_06 * g_6E;
    origin = [0;0;0] ; 
    RotN = eye(3) ;
    hold on
    
    % Plot R0 
    plot_coordinate(origin, RotN, 'green', 'O'); 
    % Plot the robot body
    for i = 1:length (g_elem)
        position = origin + RotN*g_elem(1:3,4,i);
        RotN = RotN*g_elem(1:3,1:3, i);
        plot3([origin(1) position(1)],[origin(2) position(2)],[origin(3) position(3)], 'color',[96 96 96]/255, 'LineWidth',3);
        scatter3(origin(1),origin(2),origin(3),'black','filled');
        origin = position;
    end 
    % Plot the end-effector
    position = g_0E(1:3,4);
    RotN = RotN*g_6E(1:3,1:3);
    plot3([origin(1) position(1)],[origin(2) position(2)],[origin(3) position(3)],'color',[96 96 96]/255, 'LineWidth',3);
    scatter3(position(1),position(2),position(3),'red','filled');
    %Plot the end-effector RE
    plot_coordinate(position, RotN, 'red', 'E')   
    
    xlabel('x'); ylabel('y'); zlabel('z'); grid on; 
    axis equal;
    hold on;
end


function plot_coordinate(point, RotN, color, sign)
    XYZ = [1 0 0; 0 1 0; 0 0 1];
    str = ['X','Y','Z'];
    for i = 1:3
        P = 0.1 * RotN * XYZ(i,:)';
        plot3([point(1), point(1)+ P(1)], [point(2), point(2) + P(2)], [point(3),point(3)+ P(3)],'Color',  color, 'LineWidth',2);
        text(0.04+point(1)+P(1), 0.04+point(2)+P(2), 0.04+point(3)+P(3), strcat(str(i),sign), 'Color', color);
    end
    scatter3(point(1),point(2),point(3), color, 'filled');
end
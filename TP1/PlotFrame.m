 function PlotFrame(q)
    % Parametres
    r4 = 0.2;
    r1 = 0.5;
    rE = 0.1;
    r = [r1 0 0 r4 0 0];
    d3 = 0.7;
    d = [0 0 d3 0 0 0];
    alpha = [0 pi/2 0 pi/2 -pi/2 pi/2];
    theta = q;
    theta(3) = theta(3) + pi/2;
    
    % DGM of the robot
    [g_06, g_elem]= ComputeDGM(alpha, d, theta, r);
    g_6E = TransformMatElem(0, 0, 0, rE);
    g_0E = g_06 * g_6E;  

    %Point of origin: (0,0,0)
    origin = [0;0;0] ; 
    RotN = eye(3) ;
    
    hold on
    
    plot_joint(g_elem, g_6E);
        
    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
    axis equal;
    view(-135,45)  
    hold on;
end
% % 
function plot_joint(g_elem, g_6E)
    origin = [0;0;0] ; 
    RotN = eye(3) ;

    
    % Plot R0 
    plot_coordinate(origin, RotN, 'blue', 'O');
    
    for i = 1:length (g_elem)
        position = origin +  RotN*g_elem{i}(1:3,4);
        RotN = RotN*g_elem{i}(1:3,1:3);
        plot3([origin(1) position(1)],[origin(2) position(2)],[origin(3) position(3)], 'black', 'LineWidth',3);
         scatter3(origin(1),origin(2),origin(3),'black','filled');
        origin = position;
    end
    
    % Position and orientation of End-effector
    position = origin +  RotN*g_6E(1:3,4); 
    RotN = RotN*g_6E(1:3,1:3);

    %Plot the end-effector
    plot3([origin(1) position(1)],[origin(2) position(2)],[origin(3) position(3)],'black', 'LineWidth',3);
    scatter3(position(1),position(2),position(3),'red','filled');

    %Plot the end-effector RE
    plot_coordinate(position, RotN, 'red', 'E')
end

function plot_coordinate(origin, RotN, color, sign)
    point = origin;
    rotation = RotN;
    x = [1;0;0];
    y = [0;1;0];
    z = [0;0;1];
    
    X = 0.1 * rotation * x;
    Y = 0.1 * rotation * y;
    Z = 0.1 * rotation * z;
    
    % Plot axis X
    plot3([point(1), point(1)+X(1)],  [point(2), point(2)+X(2)], [point(3), point(3)+X(3)],'Color',  color, 'LineWidth',2);
    text(0.04+point(1)+X(1), 0.04+point(2)+X(2), 0.04+point(3)+X(3), strcat('X',sign), 'Color', color);

    % Plot axis Y
    plot3([point(1), point(1)+Y(1)],[point(2), point(2)+Y(2)],[point(3), point(3)+Y(3)],'Color', color, 'LineWidth',2);
    text(0.04 +point(1)+Y(1), 0.04 +point(2)+Y(2), 0.04 +point(3)+Y(3), strcat('Y',sign), 'Color', color);

    % Plot axis Z
    plot3([point(1), point(1)+Z(1)],[point(2), point(2)+Z(2)],[point(3), point(3)+Z(3)],'Color', color, 'LineWidth',2);
    text(0.04 +point(1)+Z(1), 0.04 +point(2)+Z(2), 0.04 +point(3)+Z(3), strcat('Z',sign), 'Color', color);
    
    scatter3(origin(1),origin(2),origin(3), color, 'filled');

end
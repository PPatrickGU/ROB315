function G = ComputeGravTorque(q)

    %Parameters
    m=[15 10 1 7 1 0.5];
    x_G1 = 0; y_G1 = 0; z_G1 = -0.25;
    x_G2 = 0.35; y_G2 = 0; z_G2 = 0;
    x_G3 = 0; y_G3 = -0.1; z_G3 = 0;
    x_G4 = 0; y_G4 = 0; z_G4 = 0;
    x_G5 = 0; y_G5 = 0; z_G5 = 0;
    x_G6 = 0; y_G6 = 0; z_G6 = 0;
    x_G = [x_G1 x_G2 x_G3 x_G4 x_G5 x_G6];
    y_G = [y_G1 y_G2 y_G3 y_G4 y_G5 y_G6];
    z_G = [z_G1 z_G2 z_G3 z_G4 z_G5 z_G6];

    d = [0 0 0.7 0 0 0];
    r = [0.5 0 0 0.2 0 0];
    alpha = [0 pi/2 0 pi/2 -pi/2 pi/2];
    theta = [q(1) q(2) q(3)+pi/2 q(4) q(5) q(6)];

    % Calculation of the Jacobian matrices of each body
    [OJv_Gi, ~] = ComputeJacGi(alpha, d, theta, r, x_G, y_G, z_G);

    %Gravity vector expressed in R0
    g = [0 0 -9.81]';

    %Calculation of the torque of gravity produced by bodies
    G = zeros(length(theta), 1);
    
    for i = 1:length(m)
        G = G - OJv_Gi(:,:,i)'*m(i)*g;
    end
end
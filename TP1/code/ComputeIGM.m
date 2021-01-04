function [q_star] = ComputeIGM(Xd, q0, k_max, epsilon_x)

alpha = [0, pi/2, 0, pi/2, -pi/2, pi/2];
d = [0, 0, 0.7, 0, 0, 0];
rE = 0.1;
r = [0.5, 0, 0, 0.2, 0, 0];

k = 0;
q = q0';
alpha_step = 0.005;

for k = 1:k_max
    theta = [q(1), q(2), q(3)+pi/2, q(4), q(5), q(6)];
    [g_06, g_elem] = ComputeDGM(alpha, d, theta, r);
    g_0E = g_06*TransformMatElem(0,0,0,rE);
    fq = g_0E(1:3, 4);
    
    % compute cartesian error
    e = Xd - fq;
    
    J = ComputeJac(alpha, d, theta, r);
    Ji = J(1:3, :);
    
    % Gradient-based method
%     q = q + alpha_step*Ji'*e;

%     % Newton-Raphson method
    q = q + pinv(Ji)*e;
   
    if (norm(e,2) < epsilon_x) 
        break
    end
end
q_star = q;
end
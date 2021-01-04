function [q_star] = ComputeIGMlimites(Xd, q0, k_max, epsilon_x, aH, qmin, qmax)

% Parameters
alpha = [0, pi/2, 0, pi/2, -pi/2, pi/2];
d = [0, 0, 0.7, 0, 0, 0];
rE = 0.1;
r = [0.5, 0, 0, 0.2, 0, 0];
k = 0;
q = q0';

for k = 1:k_max
    theta = [q(1), q(2), q(3)+pi/2, q(4), q(5), q(6)];
    [g_06, g_elem] = ComputeDGM(alpha, d, theta, r);
    g_0E = g_06*TransformMatElem(0,0,0,rE);
    fq = g_0E(1:3, 4);
    
    % compute cartesian error
    e = Xd - fq;
    
    J = ComputeJac(alpha, d, theta, r);
    Ji = J(1:3, :);
    
    % Compute the potential function
    q_= (qmax - qmin)/2; 
    H = [];
    for i = 1:size(q_,2)
        H = [H;2*(q(i)-q_(i))/(qmax(i) - qmin(i))^2];
    end
    
%  Solution of the quadratic optimization
    q = q + pinv(Ji)*e + (eye(size(Ji,2))-(pinv(Ji)*Ji))*(-aH * H')';
   
    if (norm(e,2) < epsilon_x) 
        break
    end
end
q_star = q;
end
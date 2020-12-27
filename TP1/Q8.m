% Q8 compute the qstar

% Parameters
alpha = [0, pi/2, 0, pi/2, -pi/2, pi/2];
d = [0, 0, 0.7, 0, 0, 0];
r = [0.5, 0, 0, 0.2, 0, 0];
rE = 0.1;

% Parameters for the first conficuration 
Xd = [-0.1, -0.7, 0.3]';
q0 = [-1.57, 0.00, -1.47, -1.47, -1.47, -1.47];
k_max = 100;
epsilon_x = 0.001;

% Parameters for the second configuration
%  Xd = [0.64, -0.1, 1.14]';
%  q0 = [0, 0.8, 0, 1, 2, 0];
%  k_max = 100;
%  epsilon_x = 0.001;

q_star = ComputeIGM(Xd, q0, k_max, epsilon_x)

% Compute the error
theta_veri = q_star;
theta_veri(3) = theta_veri(3) + pi/2; 
[g_06,g_element] = ComputeDGM(alpha, d, theta_veri, r);
g_0E =g_06*TransformMatElem(0,0,0,rE);
diff = abs(Xd-g_0E(1:3, 4))

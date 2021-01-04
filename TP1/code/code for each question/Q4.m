qi = [-pi/2, 0, -pi/2, -pi/2, -pi/2, -pi/2]; 
qf = [0, pi/4, 0, pi/2, pi/2, 0];
d3 = 0.7;
r1 = 0.5;
r4 = 0.2;
rE = 0.1;
alpha = [0, pi/2, 0, pi/2, -pi/2, pi/2];
d = [0, 0, d3, 0, 0, 0];
theta = qi;
theta(3) = theta(3) + pi/2;
r = [r1, 0, 0, r4, 0, 0];

[g_06, g_elem]= ComputeDGM(alpha, d, theta, r);
g_6E = TransformMatElem(0, 0, 0, rE);
g_0E = g_06 * g_6E  
w_theta = tform2axang(g_0E)
w = w_theta(1:3)
theta = w_theta(4)
% Question 4:pour q=q_i: Px=-0.1m, Py=-0.7m, Pz=0.3m, n=[-0.58,-0.58,0.58]^t; q=2.09rad


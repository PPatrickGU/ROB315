clc
close all
clear all

%% parameters
qi = [-pi/2, 0, -pi/2, -pi/2, -pi/2, -pi/2]; 
qf = [0, pi/4, 0, pi/2, pi/2, 0];
d3 = 0.7;
r1 = 0.5;
r4 = 0.2;
rE = 0.1;
alpha_ = [0, pi/2, 0, pi/2, -pi/2, pi/2];
d = [0, 0, d3, 0, 0, 0];
theta = qi;
theta(3) = theta(3) + pi/2;
r = [r1, 0, 0, r4, 0, 0];

%% Q4
[g_06, g_elem]= ComputeDGM(alpha_, d, theta, r);
g_6E = TransformMatElem(0, 0, 0, rE);
g_0E = g_06 * g_6E  
w_theta = tform2axang(g_0E);
w = w_theta(1:3)
theta_ = w_theta(4)

%% Q5
figure
set(gcf,'Name','Plot Frame')
PlotFrame(theta);

%% Q6
% Speed  of joints 
q_point = [0.5 1 -0.5 0.5 1 -0.5]';

% Calculate the Jacobian matrix
J = ComputeJac(alpha_, d, theta, r);
V_oe = J * q_point;

%% Q7
J_v = J(1:3,:)

% Singular value decomposition
[U,S,V] = svd(J_v*J_v.')

% Direction_preferred
[Eigenvalue_max, idx] = max(diag(S));
direction_preferred = V(:,idx)

% Manipulabilty
eigenvalues = sqrt(diag(S))
manipulabilite = prod(eigenvalues)

% Ellipsoides
AxisValues = sqrt(diag(S));

% Rotation Axe and angle of rotation 
[g_06, g_elem]= ComputeDGM(alpha_, d, theta, r);
g_6E = TransformMatElem(0, 0, 0, rE);
g_0E = g_06 * g_6E;

% Visualisation of the robot
figure
set(gcf,'Name','Plot Ellipsoides ')
PlotFrame(qi)
hold on;

pf = g_0E(1:3,4)
w_theta = tform2axang(g_0E);
w = w_theta(1:3);
theta_ = w_theta(4);

% Velocities Ellipsoides 
[x,y,z] = ellipsoid(pf(1),pf(2),pf(3),AxisValues(1),AxisValues(2),AxisValues(3));
Ellipsoide = surf(x,y,z);
alpha 0.5;
Ellipsoide.EdgeColor = 'black';
rotate(Ellipsoide, w, radtodeg(theta_), pf);
title('Velocities Ellipsoides');

%% Q8: compute the qstar
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
[g_06,g_element] = ComputeDGM(alpha_, d, theta_veri, r);
g_0E =g_06*TransformMatElem(0,0,0,rE);
diff = abs(Xd-g_0E(1:3, 4))

%% Q9
% Parameters 
Xdi = [-0.1 -0.7 0.3]';
Xdf = [0.64 -0.1 1.14]';
V = 1;
Te = 1e-3;
q0 = [-1.57, 0.00, -1.47, -1.47, -1.47, -1.47]';
%  q0 = [0, 0.8, 0, 1, 2, 0];

[XTot, qTot] = ComputeIKM(Xdi, Xdf, V, Te, q0);

PlotTrajec(XTot, qTot);

%% Q10
% Parameters 
qmin = [-pi -pi/2 -pi -pi -pi/2 -pi];
qmax = [0 pi/2 0 pi/2 pi/2 pi/2];
PlotEvolution(qTot, qmin, qmax)

%% Q11
% Parameters 
q0 = [-1.57, 0.00, -1.47, -1.47, -1.47, -1.47]';
%  q0 = [0, 0.8, 0, 1, 2, 0];

[XTot, qTot] = ComputeIKMlimites(Xdi, Xdf, V, Te, q0, qmin, qmax);
PlotTrajec(XTot, qTot);
PlotEvolution(qTot, qmin, qmax)
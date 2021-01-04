%% Q6: Calculate the Jacobian matrix and the twist values 

% Parameters 
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

% Speed  of joints 
q_point = [0.5 1 -0.5 0.5 1 -0.5]';

% Calculate the Jacobian matrix
J = ComputeJac(alpha_, d, theta, r);
V_oe = J * q_point;

% Q7: Velocity transmissions
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
PlotFrame(theta)
hold on;

pf = g_0E(1:3,4)
w_theta = tform2axang(g_0E);
w = w_theta(1:3);
theta_ = w_theta(4);
% [theta, w] = RotMattoAngle(g_0E);
    
% Ellipsoides of speed
% [x,y,z] = 	(xc,yc,zc,xr,yr,zr,n)
[x,y,z] = ellipsoid(pf(1),pf(2),pf(3),AxisValues(1),AxisValues(2),AxisValues(3));
Ellipsoide = surf(x,y,z);
alpha 0.5;
Ellipsoide.EdgeColor = 'none';
rotate(Ellipsoide, w, radtodeg(theta_), pf);
title('Velocities Ellipsoides');


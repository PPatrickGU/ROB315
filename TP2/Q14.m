%% Q14: 
% Parameters
qmin = [-pi -pi/2 -pi -pi -pi/2 -pi];
qmax = [0 pi/2 0 pi/2 pi/2 pi/2];
N = 500
[mu1,mu2] = ComputeBounds(A, qmin, qmax, 500)
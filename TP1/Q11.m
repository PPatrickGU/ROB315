% Q11
% Parameters 
Xdi = [-0.1 -0.7 0.3]';
Xdf = [0.64 -0.1 1.14]';
V = 1;
Te = 1e-3;
qmin = [-pi -pi/2 -pi -pi -pi/2 -pi];
qmax = [0 pi/2 0 pi/2 pi/2 pi/2];

q0 = [-1.57, 0.00, -1.47, -1.47, -1.47, -1.47]';
%  q0 = [0, 0.8, 0, 1, 2, 0];

[XTot, qTot] = ComputeIKMlimites(Xdi, Xdf, V, Te, q0, qmin, qmax);

PlotTrajec(XTot, qTot);

PlotEvolution(qTot, qmin, qmax)
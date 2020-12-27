% Q9
% Parameters 
Xdi = [-0.1 -0.7 0.3]';
Xdf = [0.64 -0.1 1.14]';
V = 1;
Te = 1e-3;

q0 = [-1.57, 0.00, -1.47, -1.47, -1.47, -1.47]';
%  q0 = [0, 0.8, 0, 1, 2, 0];

[XTot, qTot] = ComputeIKM(Xdi, Xdf, V, Te, q0);

PlotTrajec(XTot, qTot);
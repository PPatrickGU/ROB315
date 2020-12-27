function [Xd, q] = ComputeIKMlimites(Xdi, Xdf, V, Te, qi, qmin, qmax)

% Parameters
kmax = 100;
epsilon_x = 0.001;
aH = 0.005;

% compute the distance between initial point and final point
distance = norm(Xdf-Xdi, 2);

% compute step length every Te
step_length = V*Te*(Xdf-Xdi)/distance;

%compute the total time
times = distance/V;

% Initiation
Xd = Xdi;
Xdk = Xdi;
q = qi;
qk = qi;
t = 0;

while(t<=times)
    Xdk = Xdk + step_length;
    qk = ComputeIGMlimites(Xdk, qk', kmax, epsilon_x, aH, qmin, qmax);
    Xd = [Xd, Xdk];
    q = [q, qk];
    t = t+Te;
end

end
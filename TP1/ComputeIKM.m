function [Xd, q] = ComputeIKM(Xdi, Xdf, V, Te, qi)

kmax = 100;
epsilon_x = 0.001;

% compute the distance between initial point and final point
distance = norm(Xdf-Xdi, 2);

% compute step length every Te
step_length = V*Te*(Xdf-Xdi)/distance;

%compute the total temps
times = distance/V;

% Initiation
Xd = Xdi;
Xdk = Xdi;
q = qi;
qk = qi;
t = 0;

while(t<=times)
    Xdk = Xdk + step_length;
    qk = ComputeIGM(Xdk, qk', kmax, epsilon_x);
    Xd = [Xd, Xdk];
    q = [q qk];
    t = t+Te;
end

end
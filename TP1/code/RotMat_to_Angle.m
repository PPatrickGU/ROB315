function [P, theta, w] = RotMat_to_Angle(g0E)

% Get the positio
P = g0E(1:3, 4);

% Get the rotation matrix
R = g0E(1:3, 1:3);

% Retrieving the angle parameters from a given rotation matrix
theta = atan2(0.5*sqrt((R(3,2)-R(2,3))^2 + (R(1,3)-R(3,1))^2 + (R(2,1)-R(1,2))^2), 0.5*(R(1,1)+R(2,2)+R(3,3)-1));

% Retrieving the axis parameters from a given rotation matrix
w = [(R(3,2)-R(2,3))/(2*sin(theta)), (R(1,3)-R(3,1))/(2*sin(theta)), (R(2,1)-R(1,2))/(2*sin(theta))];

end


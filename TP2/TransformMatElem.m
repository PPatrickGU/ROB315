function g = TransformMatElem(alpha_i, d_i, theta_i, r_i)
g = [ cos(theta_i)                -sin(theta_i)               0               d_i;
      cos(alpha_i)*sin(theta_i)   cos(alpha_i)*cos(theta_i)   -sin(alpha_i)   -r_i*sin(alpha_i);
      sin(alpha_i)*sin(theta_i)   sin(alpha_i)*cos(theta_i)   cos(alpha_i)    r_i*cos(alpha_i);
      0                           0                           0               1];
function A = ComputeMatIner(q)
    % parameters
    m=[15 10 1 7 1 0.5];   
    x_G1 = 0; y_G1 = 0; z_G1 = -0.25;
    x_G2 = 0.35; y_G2 = 0; z_G2 = 0;
    x_G3 = 0; y_G3 = -0.1; z_G3 = 0;
    x_G4 = 0; y_G4 = 0; z_G4 = 0;
    x_G5 = 0; y_G5 = 0; z_G5 = 0;
    x_G6 = 0; y_G6 = 0; z_G6 = 0;
    x_G = [x_G1 x_G2 x_G3 x_G4 x_G5 x_G6]';
    y_G = [y_G1 y_G2 y_G3 y_G4 y_G5 y_G6]';
    z_G = [z_G1 z_G2 z_G3 z_G4 z_G5 z_G6]';
    
    iI = zeros(3,3,length(q));
    iI(:,:,1)=[0.80 0 0.05 ; 0 0.80 0 ; 0.05  0  0.10];
    iI(:,:,2)=[0.10  0  0.10; 0  1.50 0 ; 0.10  0  1.50];
    iI(:,:,3)=[0.05 0 0 ; 0 0.01 0 ; 0 0 0.05];
    iI(:,:,4)=[0.50 0 0 ; 0 0.50 0 ; 0 0 0.05];
    iI(:,:,5)=[0.01 0 0 ; 0 0.01 0 ; 0 0 0.01];
    iI(:,:,6)=[0.01 0 0 ; 0 0.01 0 ; 0 0 0.01];
    
    d = [0 0 0.7 0 0 0];
    r = [0.5 0 0 0.2 0 0];
    alpha = [0 pi/2 0 pi/2 -pi/2 pi/2];
    theta = [q(1) q(2) q(3)+pi/2 q(4) q(5) q(6)]';
    
    Rred = [100 100 100 70 70 70];
    Jm = 1e-5*[1 1 1 1 1 1];
    
    % initialisation of the tables
    g_0i = eye(4);
    Ig = zeros(3*length(q),3);
    A = zeros(length(theta),length(theta));
    ROi = zeros(3,3,length(m));
    
    % Calculation of the Jacobian matrices of each body
    [OJv_Gi, OJ_wi, ROi, O0Oi] = ComputeJacGi(alpha, d, theta, r, x_G, y_G, z_G);
    % Calculation of the kinetic energy of each body
    A = zeros(length(theta), length(theta));
    for i = 1:length(m)
        %Expression of the tensor of inertia matrix iI_Gi of Ci in Ri of
        %origin Gi, in the statement of the question it's expressed in Ri
        %of origin Oi
        OPreproduitVect_OiGi = [0 -z_G(i) y_G(i); z_G(i) 0 -x_G(i); -y_G(i) x_G(i) 0];
        iI_Gi = iI(:,:,i) + m(i) * OPreproduitVect_OiGi* OPreproduitVect_OiGi; % Generalized Huygens theorem: Huygens = - OPreproduitVect_OiGi* OPreproduitVect_OiGi
        
        % Expression of inertia tensor expressed in R0
        OI_Gi = ROi(:,:,i) * iI_Gi * ROi(:,:,i)';
        A = A + ((m(i)*OJv_Gi(:,:,i)')*OJv_Gi(:,:,i) + (OJ_wi(:,:,i)')*OI_Gi*OJ_wi(:,:,i));
    end
    
    %Addition of actuator inertia contributions
    A = A + diag(Rred.^2.*Jm);
    
end

function [OJv_Gi, OJ_wi, ROi, O0Oi] = ComputeJacGi(alpha, d, theta, r, x_G, y_G, z_G)
 
    %Initialisation
    J = ComputeJac(alpha, d, theta, r); %Matrix jacobian of the robot
    
    OJ_Oi = zeros(size(J,1), size(J,2), size(J,2));
    OJ_Gi = zeros(size(J,1), size(J,2), size(J,2));
    OJv_Gi = zeros(3, size(J,2), size(J,2));  
    OJ_wi = zeros(3, size(J,2), size(J,2));
    ROi = zeros(3,3,size(J,2));
    g_0i = eye(4);
    
    % Position vector of the effector organ in R0:  
    
    [g_06, g_elem] = ComputeDGM(alpha, d, theta, r);
    rE = 0.1;
    g_6E = TransformMatElem(0,0,0,rE);
    g_0E = g_06 *g_6E;
    O0OE = g_0E(1:3, 4);
    OEO0 = -O0OE;
    
    O0Oi = zeros(3,1,6);
    
    %Loop on the bodies
    for i = 1:size(J,2)
        %Construction of all the Jacobian matrices of the fields Ci
        %expressed at the center Oi of the reference Ri attached to Ci
        OJ_Oi(:,1:i,i) = J(:,1:i);
        %OiGi vector expressed in Ri
        iOiGi = [x_G(i) y_G(i) z_G(i)]';
        %Rotation matrix ROi of the reference R0 to Ri
        g_elem = TransformMatElem(alpha(i), d(i), theta(i), r(i));
        %Rotation matrix ROi of the reference R0 to Ri
        g_0i = g_0i*g_elem;
        ROi(:,:,i) = g_0i(1:3,1:3);
        %OEGi vector in RO to be calculated: OEGi = OEOi + OiGi
        %OiGi vector expressed in R0
        OOiGi = ROi(:,:,i)*iOiGi;
        %OEOi vector expressed in R0: OEOi = OEO0 + O0Oi
        O0Oi(:,:,i) = g_0i(1:3,4);
        OEOi = OEO0 + O0Oi(:,:,i);
        OOEGi = OEOi + OOiGi;
        OPreproduitVect_OEGi = [0 -OOEGi(3) OOEGi(2);...
                                OOEGi(3) 0 -OOEGi(1);...
                                -OOEGi(2) OOEGi(1) 0];
        %Formula of Varignon, the Rodrigus formula 
        OJ_Gi(:,:,i) =  [eye(3) -OPreproduitVect_OEGi;...
                        zeros(3,3) eye(3)]*OJ_Oi(:,:,i);
        
        %Results
        OJv_Gi(:,:,i) = OJ_Gi(1:3,:,i);
        OJ_wi(:,:,i) = OJ_Gi(4:6,:,i);
    end
end

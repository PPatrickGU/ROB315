function J = ComputeJac(alpha, d, theta, r)
    rE = 0.1;    
    [g_06, g_elem] = ComputeDGM(alpha, d, theta, r);
    g_6E  = TransformMatElem(0, 0, 0, rE);
    g_0E = g_06 * g_6E;   
    
    N = size(alpha, 2);     
    
    % Initialisation of the Jacobian matrix 
    J = zeros(6,N);      
    % unit vector of the ith joint in frame Ri
    z_i = [0 0 1]';        

    for i=1:N
        p_iE = zeros(3,1);
        g_0i = eye(4);
        for j=1:i
            g_0i = g_0i*g_elem(:,:,j);
        end
 
        % Calculate R_0i
        R_0i = g_0i(1:3,1:3);

        % Calculate p_iE (translation vecteur from R_i to R_E)
        p_0E = g_0E(1:3,4);

        p_0i = g_0i(1:3,4);
        p_iE = p_0E - p_0i;

        % Calculate Ji in reference R_0
        oJi = [cross(R_0i*z_i,p_iE) ; R_0i*z_i];

        %Concatenation of J
        J(1:6,i) = oJi;
    end
end
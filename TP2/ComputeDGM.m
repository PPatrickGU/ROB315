function [g_06, g_elem] = ComputeDGM(alpha, d, theta, r)
    g_06 = eye(4);
    N = size(alpha,2);
    g_elem = zeros(size(g_06,1), size(g_06,2), N);
    for i = 1:N
        g_elem(:, :, i) = TransformMatElem(alpha(i), d(i), theta(i), r(i));
        g_06 = g_06 *  g_elem(:, :, i);
    end
end
        
%     alpha = [0 pi/2 0 pi/2 -pi/2 pi/2]
%     d = [0 0 0.7 0 0 0 ]
%     qi = [-pi/2 0 -pi/2 -pi/2 -pi/2 -pi/2]
%     qf = [0 pi/4 0 pi/2 pi/2 0]
%     theta = qi
%     r = [0.5 0 0 0.2 0 0 0.1]
    
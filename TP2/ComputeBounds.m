function [mu1, mu2] = ComputeBounds(A, qmin, qmax, N) 
    %N: number of iterations
    dq = (qmax-qmin)/N;
    q = qmin;
    mu1 = inf;
    mu2 = 0;
    for i = 1:N
        q = q + dq;
        A = ComputeMatIner(q);
        if max(eig(A)) > mu2
            mu2 = max(eig(A));
        end
        if min(eig(A)) < mu1
            mu1 = min(eig(A)) ;        
        end
    end
end
function [maxG] = FindMajorantG (G, qmin,qmax, NumTry)
    maxG = 0;
    
    % Nous allons faire varier les q entre qmin et qmax
    dq = (qmax-qmin)/NumTry;
    qCur = qmin;
    for i = 1 : NumTry
        qCur = qCur + dq;
        G = CalculCoupleGravite(qCur);
        curG = norm(G,1);
        if curG > maxG
            maxG = curG;
        end
    end
end
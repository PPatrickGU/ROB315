function Gamma = ComputeFrictionTorque(dq_dt)
    % parameters
    Fv = 10*ones(length(dq_dt), 1);
    Gamma = diag(dq_dt)* Fv;
end
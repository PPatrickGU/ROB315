function qc = GenTraj(q_di, q_df, t)
    tf = 500;
    D = q_df - q_di;
    r = 10*(t/tf)^3 -15*(t/tf)^4 + 6*(t/tf)^5;
    qc = q_di + r*D
end
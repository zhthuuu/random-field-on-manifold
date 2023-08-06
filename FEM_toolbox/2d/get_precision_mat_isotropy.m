% solve the tengential SPDE problem for 2d isotropic random field
% Hao Zhang, 02.24.2020
function [R, flag, transP] = get_precision_mat_isotropy(kappa, P, t, normconst)
    norm_vec = face_norm(P, t);
    numNodes = size(P, 1);
    [M,G] = fast_assemble_MG(P, t, norm_vec);
    idx_vec = 1:numNodes;
    values_vec = sum(M,2);
    M_dump = sparse(idx_vec, idx_vec, values_vec);
    disp("Now calculate Q matrix...");
    K = kappa^2*M_dump + G;
    Q = K * ((normconst*M_dump) \ K);
    disp("Chol decomposition..."); 
    Q = sparse(Q);
    [R, flag, transP] = chol(Q);
end  







% solve the tengential SPDE problem to get isotropic/anisotropic Gaussian
% random field
% varargin
% Hao, 02.24.2020
function [R, flag, transP] = get_precision_mat_anisotropy(kappa, P, t, normconst, lambda, global_gradu)
    numNodes = length(P);
    norm_vecs = face_norm(P, t);
    [M,G] = fast_assemble_MG(P, t, norm_vecs, lambda, global_gradu);
    idx_vec = 1:numNodes;
    values_vec = sum(M,2);
    M_dump = sparse(idx_vec, idx_vec, values_vec);
    disp("Now calculate Q matrix...");
    K = kappa^2*M_dump + G;
    Q = K * ((normconst*M_dump) \ K);
    disp("Chol decomposition..."); 
    Q = sparse(Q);
    [R, flag, transP] = chol(Q);
%     detH = get_detH(lambda, global_gradu, 1:length(t));
end





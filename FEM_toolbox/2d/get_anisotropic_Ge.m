% gradient matrix, adding diffusion matrix H
% varargin: {P, t, elementNo, normvecs, lambda, global_gradu}
function Ge = get_anisotropic_Ge(P, t, elementNo, normvecs, lambda, global_gradu)
    Ge = zeros(3);
    J = Jacobi_mat(P, t, elementNo, normvecs);
    H = get_H(lambda, global_gradu, elementNo);
    gradN = [get_gradN();
             0, 0, 0];
    B = J \ gradN;
    Ge = Ge + 1/2*B'*(H*B)*det(J); % weight = 1/6, 3 points, add equal 1/2
end
% gradient matrix, adding diffusion matrix H
function Ge = get_anisotropic_Ge(P, t, lambda, global_gradu, elementNo)
    connectivity = t(elementNo, :);
    coord = P(connectivity, :);
    Ge = zeros(4);
    H = get_H(lambda, global_gradu, elementNo);
    J = Jacobi_mat(P, t, elementNo);
    gradN = get_gradN();
    B = J \ gradN;
    Ge = Ge + 1/6*B'*(H*B)*abs(det(J)); % weight = 1/4, four points, add equal 1
end
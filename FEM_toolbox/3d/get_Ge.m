% gradient matrix
function Ge = get_Ge(P, t, elementNo)
    connectivity = t(elementNo, :);
    coord = P(connectivity, :);
    Ge = zeros(4);
    J = Jacobi_mat(P, t, elementNo);
    gradN = get_gradN();
    B = J \ gradN;
    Ge = Ge + 1/6*(B'*B)*abs(det(J)); % weight = 1/4, 4 points, sum = 1
end
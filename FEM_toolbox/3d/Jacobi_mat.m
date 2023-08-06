% Jacobi matrix of tetrahedral element
function J = Jacobi_mat(P, t, elementNo)
    connectivity = t(elementNo, :);
    coord = P(connectivity, :);
    gradN = get_gradN();
    J = gradN * coord;
    % X = coord(:, 1);
    % Y = coord(:, 2);
    % Z = coord(:, 3);
    % J = [X(2)-X(1), Y(2)-Y(1), Z(2)-Z(1);
    %      X(3)-X(1), Y(3)-Y(1), Z(3)-Z(1);
    %      X(4)-X(1), Y(4)-Y(1), Z(4)-Z(1)];
    assert(det(J) ~= 0, "det(J) = 0!");
end
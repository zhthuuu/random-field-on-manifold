function [uxx, uyy] = get_gradu(P, t, u)
    gradu = zeros(length(t), 2);
    for i=1:length(t)
       gradu(i,:) = get_gradue(P, t, u, i); 
    end
    uxx = gradu(:,1);
    uyy = gradu(:,2);
end

function gradue = get_gradue(P, t, u, elementNo)
    gradN = get_gradN();
    J = Jacobi_mat(P, t, elementNo);
    B = J \ gradN;
    connectivity = t(elementNo, :);
    ue = u(connectivity);
    gradue = B * ue;
end
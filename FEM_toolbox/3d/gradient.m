function [uxx, uyy, uzz] = gradient(P, t, u)
    gradu = zeros(length(t), 3);
    for i=1:length(t)
       gradu(i,:) = get_grade(P, t, u, i); 
    end
    uxx = gradu(:,1);
    uyy = gradu(:,2);
    uzz = gradu(:,3);
end

function grad_ue = get_grade(P, t, u, elementNo)
    gradN = get_gradN();
    J = Jacobi_mat(P, t, elementNo);
    B = J \ gradN;
    connectivity = t(elementNo, :);
    ue = u(connectivity);
    grad_ue = B * ue;
end
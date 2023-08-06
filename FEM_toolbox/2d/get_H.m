% construct diffusion matrix H
function H = get_H(lambda, global_gradu, elementNo)
    gradu1 = global_gradu.gradu1(elementNo, :)';
    gradu2 = global_gradu.gradu2(elementNo, :)';
    gradu3 = global_gradu.gradu3(elementNo, :)';
    H = lambda(1) * (gradu1 * gradu1') + lambda(2) * (gradu2 * gradu2') + ...
        + lambda(3) * (gradu3 * gradu3');
    assert(det(H) ~= 0, "det(H) = 0!");
end
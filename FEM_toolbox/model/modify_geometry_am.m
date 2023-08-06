% modify the surface geometry by changing the surface coordinates
% For additive manufacturing
function [P_modified, eta_beta] = modify_geometry_am(P, t, eta_norm, height, delta, meshsize)
    vecs = find_perturb_vec_am(P, t, meshsize);
%     vecs = find_perturb_vec_cylinder(P, t, meshsize);
    eta_beta = -1 * convert_beta(height, delta, eta_norm, 'positive'); % convert norm to beta distribution
    P_modified = vecs.*eta_beta + P; % modified height 
end

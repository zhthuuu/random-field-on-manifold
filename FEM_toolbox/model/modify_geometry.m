% modify the surface geometry by changing the surface coordinates
function [P_modified, eta_beta] = modify_geometry(P, t, height, delta, eta_norm, direction)
    norm_node = find_node_norm(P, t);
    eta_beta = convert_beta(height, delta, eta_norm, direction); % convert norm to beta distribution
    P_modified = norm_node.*eta_beta + P; % modified height 
end

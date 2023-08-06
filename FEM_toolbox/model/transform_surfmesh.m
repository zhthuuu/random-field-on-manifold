function [p, t] = surface_mesh(P, tri_sphere)
    [c, ~, ic] = unique(tri_sphere);
    p = P(c,:);
    numElements = length(tri_sphere);
    idx = linspace(1, numElements, numElements)';
    t = idx(ic);
    t = reshape(t, length(t)/3, 3);
end
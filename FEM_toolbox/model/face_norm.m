function norm_vec = face_norm(P, tri_sphere)
    p1= P(tri_sphere(:,1), :);
    p2= P(tri_sphere(:,2), :);
    p3= P(tri_sphere(:,3), :);
    v1 = p1 - p2;
    v2 = p1 - p3;
    norm_vec = cross(v1, v2);
    norm_vec = norm_vec ./ vecnorm(norm_vec, 2, 2);
end
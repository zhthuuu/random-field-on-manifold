% construct diffusion matrix H
function v = get_v(P, t)
    normvecs = face_norm(P, t);
    v = zeros(length(t),3);
    for i = 1:length(v)
       J = Jacobi_mat(P, t, i, normvecs); 
       vv = J \ [-1;-1;0];
       vv = vv/norm(vv);
       v(i,:) = vv';
    end
end
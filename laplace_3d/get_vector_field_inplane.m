function gradu_global = get_vector_field_inplane(P, t, u1, u2, u3)
    addpath ../FEM_toolbox/3d
    addpath ../FEM_toolbox/model
    [~, ~, element_no_sphere, norm_vec] = sphere_tri(P, t);
    numElement = size(t, 1);
    gradu_global = struct('gradu1', zeros(numElement, 3), ...
                          'gradu2', zeros(numElement, 3), ...
                          'gradu3', zeros(numElement, 3));
    for i = 1:numElement
       gradu1 = element_grad_global(P, t, u1, i);
       gradu2 = element_grad_global(P, t, u2, i);
       gradu3 = element_grad_global(P, t, u3, i);
       gradu_global.gradu1(i, :) = gradu1;
       gradu_global.gradu2(i, :) = gradu2;
       gradu_global.gradu3(i, :) = gradu3;
       % gradu_global.gradu3(i, :) = cross(gradu1, gradu2);
    end
    
    for i = 1:size(element_no_sphere, 1)
       nhat = norm_vec(i, :);
       element_no = element_no_sphere(i);
       gradu1_proj = grad_plane(P, t, u1, element_no, nhat);
       gradu2_proj = grad_plane(P, t, u2, element_no, nhat);
       gradu3_proj = grad_plane(P, t, u3, element_no, nhat);
       % gradu3_proj = cross(gradu1_proj, gradu2_proj);
       % area3 = sqrt(gradu3_proj(1)^2+gradu3_proj(2)^2+gradu3_proj(3)^2);
       % gradu3_proj = gradu3_proj/area3;
       gradu_global.gradu1(element_no, :) = gradu1_proj;
       gradu_global.gradu2(element_no, :) = gradu2_proj;
       gradu_global.gradu3(element_no, :) = gradu3_proj;
    end
end

function vec = grad_plane(P, t, u, elementNo, nhat)
    gradu_proj = element_grad(P, t, u, elementNo, nhat);
    vec = zeros(size(gradu_proj));
    vec(1) = gradu_proj(1);
    vec(2) = gradu_proj(2);
    area = sqrt(vec(1)^2+vec(2)^2);
    vec = vec/area;
end

% given vector e1 and e2, calculate the vertical part of e2 to e1
function n2 = verticle(e1, e2)
    length_e1 = norm(e1, 2);
    e1_direction = e1/length_e1;
    n2 = e2 - dot(e2, e1_direction) * e1_direction;
    length_n2 = norm(n2, 2);
    n2 = n2 / length_n2;
end

function gradu_proj = element_grad(P, t, u, elementNo, nhat)
    connectivity = t(elementNo, :);
    u_element = u(connectivity, :);
    J = Jacobi_mat(P, t, elementNo);
    gradN = get_gradN();
    B = J \ gradN;
%     nhat = norm_vec(element_no_sphere == elementNo, :)';
    gradu = B * u_element; % 3*1 vector
    area_hat = sqrt(nhat(1)^2+nhat(2)^2+nhat(3)^2);
    gradu_norm = (dot(gradu',nhat)/area_hat) * nhat;
    gradu = gradu' - gradu_norm;
    area_gradu = sqrt(gradu(1)^2+gradu(2)^2+gradu(3)^2);
    gradu_proj = gradu / area_gradu;
end

function gradu = element_grad_global(P, t, u, elementNo)
    connectivity = t(elementNo, :);
    u_element = u(connectivity, :);
    J = Jacobi_mat(P,t,elementNo);
    gradN = get_gradN();
    B = J \ gradN;
    gradu = B * u_element;
    area_gradu = sqrt(gradu(1)^2+gradu(2)^2+gradu(3)^2);
    gradu = gradu'/area_gradu;
end



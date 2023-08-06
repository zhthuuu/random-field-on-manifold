% consider the additive manufacturing process
% the perturbation direction is always on x-y plane
% the direction is limited, like only with two angles, {60, -60}degree
function perturb_vecs = find_perturb_vec_cylinder(P, t, meshsize)
    element_norm = face_norm(P, t); % norm vector on each tri element
    node_norms{length(P)} = []; % initialize cell array for nodal norms
    perturb_vecs = zeros(size(P)); % initialize the perturb vectors
    H = max(P(:,3)) - min(P(:,3));
    bottom_z = min(P(:,3)) + 0.1*H;
    up_z = max(P(:,3))-0.1*H;
    for i=1:length(t)
       idx = t(i,:);
       node_norms{idx(1)} = [node_norms{idx(1)}; element_norm(i,:)];
       node_norms{idx(2)} = [node_norms{idx(2)}; element_norm(i,:)];
       node_norms{idx(3)} = [node_norms{idx(3)}; element_norm(i,:)];
    end
    for i=1:length(P)
        z = P(i,3); 
        if z < bottom_z || z > up_z
            continue;
%         elseif x>3.2 || x<0.4
%             continue;
%         elseif y>3 || y<0.4
%             continue;
%         else
        end
        layer = round(P(i,3)/meshsize);
        angle = pi/3*mod(layer, 6);
        vec = [cos(angle), sin(angle), 0];
        curr_norms = node_norms{i}; % calc nodal norm vector
        node_norm = mean(curr_norms, 1);
%         disp(vec);
%         disp(node_norm);
        if dot(vec, node_norm) < 0
            vec = -vec;
        end
        perturb_vecs(i,:) = vec;
    end
end

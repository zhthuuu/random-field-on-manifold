% find the normal vectors at each node
function norms = find_node_norm(P, t)
    element_norm = face_norm(P, t); % norm vector on each tri element
    norms = zeros(size(P, 1), 3); % norm vector on each node
    node_norms{length(P)} = []; % initialize cell array
    for i=1:length(t)
       idx = t(i,:);
       node_norms{idx(1)} = [node_norms{idx(1)}; element_norm(i,:)];
       node_norms{idx(2)} = [node_norms{idx(2)}; element_norm(i,:)];
       node_norms{idx(3)} = [node_norms{idx(3)}; element_norm(i,:)];
    end
    center = [-112.5,110];
    for i=1:length(P)
        curr_norms = node_norms{i};
%         if ~large_deformed(curr_norms)
%             norms(i,:) = mean(curr_norms, 1) / norm(mean(curr_norms, 1));
%         end
        if norm(P(i,1:2)-center) > 2.5 || P(i,3) <30 || P(i,3) >50
            % regions near outer boundary should not be changed
            norms(i,:) = [0,0,0];
        else
            norms(i,:) = mean(curr_norms, 1) / norm(mean(curr_norms, 1));
        end
    end
end

% check if the local deformation of the node is too large
function res = large_deformed(norms)
    ref = norms(1,:);
    for i=1:size(norms,1)
        dot_res = dot(ref, norms(i,:));
        if dot_res < 0.8
            res = 1;
            return;
        end
    end
    res = 0;
end

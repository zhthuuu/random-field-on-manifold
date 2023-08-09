function [p, t, FIXEDNODES] = generate_grid_mesh(s)
    % generate nodes and connectivity for grid mesh (size 1x1)
    % record node coordinates [x, y]
    % s : number of element per edge
    l = 1;
    nnode = s * s;
    p = zeros(nnode, 2);
    lw = l/(s); lh = l/(s);
    for i = 1:(s+1)*(s+1)
        column = rem(i, s+1);
        if column == 0
            column = s + 1;
        end
        row = (i-column)/(s+1)+1;
        coord_x = lw*(column-1);
        coord_y = lh*(row-1);
        p(i, :) = [coord_x, coord_y];
    end

    % record the node No. given an element No.
    numNode = (s+1) * (s+1);
    node_matrix = reshape(1:numNode, s+1, s+1)';
    t4 = reshape(node_matrix(1:end-1, 1:end-1)', [], 1);
    t3 = reshape(node_matrix(1:end-1, 2:end)', [], 1);
    t2 = reshape(node_matrix(2:end, 2:end)', [], 1);
    t1 = reshape(node_matrix(2:end, 1:end-1)', [], 1);
    t = [t1, t2, t3, t4];
    t = flip(t, 2);

    % the fixed nodes
    FIXEDNODES = [node_matrix(:,1); node_matrix(:,end); node_matrix(1,:)'; node_matrix(end,:)'];
    FIXEDNODES = unique(FIXEDNODES);

end
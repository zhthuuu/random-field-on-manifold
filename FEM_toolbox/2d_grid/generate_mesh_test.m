function [p, t] = generate_mesh_test(nelems_w, nelems_h, width, height)

    % record node coordinates [nodeNo, x, y]
    p = zeros((nelems_w+1)*(nelems_h+1), 2);
    for i = 1:(nelems_h+1)*(nelems_w+1)
        column = rem(i, nelems_w+1);
        if column == 0
            column = nelems_w + 1;
        end
        row = (i-column)/(nelems_w+1)+1;
        coord_x = width/nelems_w*(column-1);
        coord_y = height/nelems_h*(row-1);
        p(i, :) = [coord_x, coord_y];
    end
    % record the node No. given an element No.
    t = zeros(nelems_w*nelems_h, 4);
    for i = 1 : nelems_w*nelems_h
        column = rem(i, nelems_w);
        if column == 0
            column = nelems_w;
        end
        row = (i-column)/(nelems_w);
        start = row * (nelems_w+1) + column;
        t(i,:) = [start, start+1, ...
            start+nelems_w+2, start+nelems_w+1];
    end

end
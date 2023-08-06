% another way to construct sparse stiffness matrix
% more efficient than the previous one
function M = fast_assemble(p, t, type)
    numNodes = length(p);
    numElements = length(t);
    row_vec = []; col_vec = []; values = [];
    num_dof = 3;
    m = meshgrid(1:num_dof);
    mt = m';
    idx_start = 0;
    idx_vec = 1:num_dof*num_dof;
    for i = 1:numElements
        if type=='M'
            mat = get_Me(p, t, i);
        elseif type=='G'
            mat = get_Ge(p, t, i);
        else
            disp("specify a type M/G")
            return
        end
        con = t(i,:);
        curr_idx = idx_start + idx_vec;    
        row_vec(curr_idx) = con(mt(:))';
        col_vec(curr_idx) = con(m(:))';
        values(curr_idx) = mat(:);
        idx_start = idx_start+num_dof^2;
    end
    M = sparse(row_vec, col_vec, values, numNodes, numNodes);
end
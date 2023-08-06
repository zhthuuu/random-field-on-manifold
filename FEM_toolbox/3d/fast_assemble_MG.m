% another way to construct sparse stiffness matrix
% more efficient than the previous one
% varargin{1}: lambda
% varargin{2}: global_gradu
function [M, G] = fast_assemble_MG(p, t, varargin)
    numNodes = length(p);
    numElements = length(t);
    row_vec = []; col_vec = []; values_M = []; values_G = [];
    num_dof = 4;
    m = meshgrid(1:num_dof);
    mt = m';
    idx_start = 0;
    idx_vec = 1:num_dof*num_dof;
    for i = 1:numElements
        Me = get_Me(p, t, i);
        if nargin==4
            Ge = get_anisotropic_Ge(p, t, varargin{1}, varargin{2}, i);
        elseif nargin==2
            Ge = get_Ge(p, t, i);
        else
            disp('Input argument number is not correct.');
            return
        end
        con = t(i,:);
        curr_idx = idx_start + idx_vec;    
        row_vec(curr_idx) = con(mt(:))';
        col_vec(curr_idx) = con(m(:))';
        values_M(curr_idx) = Me(:);
        values_G(curr_idx) = Ge(:);
        idx_start = idx_start+num_dof^2;
    end
    M = sparse(row_vec, col_vec, values_M, numNodes, numNodes);
    G = sparse(row_vec, col_vec, values_G, numNodes, numNodes);
end
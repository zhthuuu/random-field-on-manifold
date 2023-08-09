% another way to construct sparse stiffness matrix
% more efficient than the previous one
% varargin{1}: lambda 
% varargin{2}: global_gradu
function [M, G] = fast_assemble_MG(P, t, varargin)
    numNodes = length(P);
    numElements = length(t);
    row_vec = []; col_vec = []; values_M = []; values_G = [];
    num_dof = 4;
    m = meshgrid(1:num_dof);
    mt = m';
    idx_start = 0;
    idx_vec = 1:num_dof^2;
    for i = 1:numElements
        Me = get_Me(P, t, i);
        if nargin==2
            Ge = get_Ge(P, t, 1);
        elseif nargin==4
            Ge = get_anisotropic_Ge(P, t, i, varargin{1}, varargin{2});
        else
            disp('Input argument number is incorrect!');
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
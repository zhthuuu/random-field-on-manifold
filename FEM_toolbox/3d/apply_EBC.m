%% Modify global force vector and global stiffness matrix to enforce EBCs
% Fmod: modified global force vector
% Kmod: modified global stiffness matrix
%    K: global stiffness matrix
%    F: global force vector
%  EBC: essential boundary condition information
function [Kmod, Fmod] = apply_EBC(K, F, EBCVec)
    % Apply constraints
    Kmod = K;
    EBC = EBCVec;
    Fmod = F - Kmod(:, EBC(:,1)) * EBC(:,2);
    Fmod(EBC(:,1)) = EBC(:,2);
    Kmod(:, EBC(:,1)) = 0;
    Kmod(EBC(:,1), :) = 0;
   for i = 1:length(EBC)
       Kmod(EBC(i,1), EBC(i,1)) = 1;
   end
    % apply EBC
%     for i = 1 : size(EBC, 1)
%       % node where EBC is applied
%       node = EBC(i, 1);
%       % value of the EBC
%       value = EBC(i, 2);
%       Kmod(node, node) = 0;
%       Fmod(node, :) = value;
%       Fmod = Fmod - repmat(Kmod(:, node)*value, 1, size(F,2));
%       Kmod(:, node) = 0;
%       Kmod(node, :) = 0;
%       Kmod(node, node) = 1;
%     end
%     disp(F);
%     disp(Fmod);
%     disp(Kmod);
end
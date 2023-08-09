%% Modify global force vector and global stiffness matrix to enforce EBCs
% Fmod: modified global force vector
% Kmod: modified global stiffness matrix
%    K: global stiffness matrix
%    F: global force vector
%  EBC: essential boundary condition information
function [Kmod, Fmod] = apply_EBC(K, F, EBC)
    Kmod = K;
    % Fmod = F - Kmod(:, EBC(:,1)) * EBC(:,2);
    Fmod = F - repmat(Kmod(:, EBC(:,1)) * EBC(:,2), 1, size(F,2));
    Fmod(EBC(:,1), :) = repmat(EBC(:,2), 1, size(F,2));
    Kmod(:, EBC(:,1)) = 0;
    Kmod(EBC(:,1), :) = 0;
   for i = 1:length(EBC)
       Kmod(EBC(i,1), EBC(i,1)) = 1;
   end
end
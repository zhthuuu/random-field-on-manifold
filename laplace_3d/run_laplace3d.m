function [u] = run_laplace3d(P, t, position)
    addpath('../FEM_toolbox/3d')
    numNodes = size(P,1);
    p_cube = get_tri_cube(P, t);
    geo.left = min(P(p_cube,1)); geo.right = max(P(p_cube,1)); 
    geo.up = max(P(p_cube,3)); geo.down = min(P(p_cube,3));
    geo.front = max(P(p_cube,2)); geo.back = min(P(p_cube,2));
    ebc.left = 0; ebc.right = 1; ebc.up = 1; ebc.down = 0; ebc.back=0; ebc.front=1;
    if position=="left"
        EBCvec = construct_leftEBC(P, p_cube, geo, ebc);
    elseif position=="up"
        EBCvec = construct_upEBC(P, p_cube, geo, ebc);
    elseif position=="front"
        EBCvec = construct_frontEBC(P, p_cube, geo, ebc);
    else
        disp("specify a position! left or up");
        return;
    end
    K = fast_assemble(P, t, "G");  % the important matrix Q R
    F = zeros(numNodes, 1);
    [Kmod, Fmod] = apply_EBC(K, F, EBCvec);
%     [R, flag, transP] = chol(Kmod);
    u = Kmod \ Fmod;
%     disp("Now solving u");
%     setup = struct('type','nofill','michol','on');
%     L = ichol(Kmod,setup);
%     [u,fl1,rr1,it1,rv1,rvcg1] = minres(Kmod, Fmod, 1e-8, 100, L, L');
%     u = minres(Kmod, Fmod, 1e-8,30);
end
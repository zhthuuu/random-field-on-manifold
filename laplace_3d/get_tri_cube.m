function p_cube = get_tri_cube(P, t)
    addpath ..
    tri = surftri(P, t);
    [pold,~,tnew]=unique(tri(:));
    tnew=reshape(tnew,size(tri));
    % generate graph
    s1=cat(1,tnew(:,1),tnew(:,1),tnew(:,2));
    s2=cat(1,tnew(:,2),tnew(:,3),tnew(:,3));
    G=graph(s1(:),s2(:));
    bins = conncomp(G);
    % output point sets for each surface separated
    p_cube=pold(bins==1);
end
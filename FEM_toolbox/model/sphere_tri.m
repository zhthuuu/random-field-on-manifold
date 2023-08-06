function [p_sphere, tri_sphere, tid_sphere, nhat_sphere] = sphere_tri(P, t)
    [tri,node5,nhat] = surftri(P, t);
    [pold,~,tnew]=unique(tri(:));  % reindex triangles to extract a smaller graph
    tnew=reshape(tnew,size(tri));
    s1=cat(1,tnew(:,1),tnew(:,1),tnew(:,2));
    s2=cat(1,tnew(:,2),tnew(:,3),tnew(:,3));
    G=graph(s1(:),s2(:));
    bins_p = conncomp(G); % bins on points
    bins_t = bins_p(tnew(:)); 
    bins_t = reshape(bins_t, size(tri)); % bins on tris
    p_sphere=pold(bins_p==2);
    tri_sphere = tri(bins_t(:,1)==2,:);
    tid_sphere = node5(bins_t(:,1)==2);
    nhat_sphere = nhat(bins_t(:,1)==2, :);
end
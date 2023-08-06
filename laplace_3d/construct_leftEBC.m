function EBCvec = construct_leftEBC(P, p_sphere, geo, ebc)
    EBCvec = [];
    numNodes = length(p_sphere);
    for i=1:numNodes
       if P(p_sphere(i),1) == geo.left
           EBCvec = cat(1, EBCvec, [p_sphere(i), ebc.left]);
       elseif P(p_sphere(i), 1) == geo.right
           EBCvec = cat(1, EBCvec, [p_sphere(i), ebc.right]);
       else
           continue;
       end
    end
end
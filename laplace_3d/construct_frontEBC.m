function EBCvec = construct_frontEBC(P, p_sphere, geo, ebc)
    EBCvec = [];
    numNodes = length(p_sphere);
    for i=1:numNodes
       if P(p_sphere(i),2) == geo.back
           EBCvec = cat(1, EBCvec, [p_sphere(i), ebc.back]);
       elseif P(p_sphere(i), 2) == geo.front
           EBCvec = cat(1, EBCvec, [p_sphere(i), ebc.front]);
       else
           continue;
       end
    end
end
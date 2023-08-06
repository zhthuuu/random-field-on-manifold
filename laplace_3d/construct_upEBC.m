function EBCvec = construct_upEBC(P, p_sphere, geo, ebc)
    EBCvec = [];
    numNodes = length(p_sphere);
    for i=1:numNodes
       if P(p_sphere(i),3) == geo.down
           EBCvec = cat(1, EBCvec, [p_sphere(i), ebc.down]);
       elseif P(p_sphere(i), 3) == geo.up
           EBCvec = cat(1, EBCvec, [p_sphere(i), ebc.up]);
       else
           continue;
       end
    end
end
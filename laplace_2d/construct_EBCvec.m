function EBCvec = construct_EBCvec(P, x_left, x_right, ebc_left, ebc_right)
    EBCvec = [];
    numNodes = length(P);
    for i=1:numNodes
       if P(i,1) == x_left
           EBCvec = cat(1, EBCvec, [i, ebc_left]);
       elseif P(i, 1) == x_right
           EBCvec = cat(1, EBCvec, [i, ebc_right]);
       else
           continue;
       end
    end
end
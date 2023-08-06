function detH = get_detH(lambda, global_gradu, elementNo)
    detH = zeros(1, length(elementNo));
    for i=1:length(elementNo)
        H = get_H(lambda, global_gradu, elementNo(i));
        detH(i) = det(H);
    end
end
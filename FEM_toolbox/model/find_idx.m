% find the idx vector with corresponding distance
function [idxvec, newx] = find_idx(dis, x, lim)
    len = length(x);
    idxvec = zeros(len, 1);
    newx = zeros(len, 1);
    for i=1:len
        if i<len/5
            local_lim = lim/3;
        else
            local_lim = lim;
        end
        for j=1:length(dis)
            if abs(dis(j)-x(i)) < local_lim
                idxvec(i) = j;
                newx(i) = dis(j);
            end
        end
        if idxvec(i) == 0
            disp('cannot find idx');
            return;
        end
    end
    disp('Done finding idx vector');
end
% shape function for triangle element
% define the shape function, note the order of the 4 shape functions
% N4----N3
% |     |
% |     |
% N1----N2
function N = shape_fun_Q4(x, y)
    N1 = 1/4*(1-x)*(1-y);
    N2 = 1/4*(1+x)*(1-y);
    N3 = 1/4*(1+x)*(1+y);
    N4 = 1/4*(1-x)*(1+y);
    N = [N1;N2;N3;N4];
end
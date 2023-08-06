% shape function for triangle element
function N = shape_fun(x, y)
    N1 = x;
    N2 = y;
    N3 = 1-x-y;
    N = [N1; N2; N3];
end
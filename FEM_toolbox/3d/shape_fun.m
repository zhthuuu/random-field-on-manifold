% shape function for tetrahedral element
function N = shape_fun(x, y, z)
    N2 = x;
    N3 = y;
    N4 = z;
    N1 = 1-x-y-z;
    N = [N1; N2; N3; N4];
end
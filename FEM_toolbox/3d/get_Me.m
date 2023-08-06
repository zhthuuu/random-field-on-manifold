% Me matrix
function Me = get_Me(P, t, elementNo)
    Me = zeros(4);
    % use 4-point Gaussian quadrature for 3D integration
    wt = [1/4, 1/4, 1/4, 1/4]; 
    x = [0.13819660, 0.13819660, 0.13819660, 0.58541020];
    y = [0.13819660, 0.13819660, 0.58541020, 0.13819660];
    z = [0.13819660, 0.58541020, 0.13819660, 0.13819660];
    J = Jacobi_mat(P, t, elementNo);
    for i = 1:size(x,2)
       N = shape_fun(x(i), y(i), z(i));
       Me = Me + wt(i)*(N*N')*abs(det(J))/6;
    end 
end
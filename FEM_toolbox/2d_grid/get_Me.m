% Me matrix
% varargin: {P, t, elementNo}
function Me = get_Me(varargin)
    Me = zeros(4,4);
    % Gaussian quadrature point
    gqt = 1/sqrt(3);
    x(1) = -gqt; y(1) = -gqt;
    x(2) =  gqt; y(2) = -gqt;
    x(3) =  gqt; y(3) =  gqt;
    x(4) = -gqt; y(4) =  gqt;
    % Gaussian quadrature weights
    wt = [1 1 1 1];
    P = varargin{1}; 
    t = varargin{2};
    elementNo = varargin{3};
    for i = 1:length(x)
        J = Jacobi_mat_Q4(P, t, elementNo, x(i), y(i));
        N = shape_fun_Q4(x(i), y(i));
        Me = Me + wt(i)*(N*N')*det(J);
    end 
end
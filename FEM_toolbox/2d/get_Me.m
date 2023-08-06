% Me matrix
function Me = get_Me(varargin)
    Me = zeros(3);
    % Gaussian quadrature
    wt = [1/6, 1/6, 1/6]; 
    x = [1/6, 2/3, 1/6];
    y = [1/6, 1/6, 2/3];
    if nargin==3
        J = Jacobi_mat(varargin{1}, varargin{2}, varargin{3});
    else
        J = Jacobi_mat(varargin{1}, varargin{2}, varargin{3}, varargin{4});
    end
    for i = 1:size(x,2)
       N = shape_fun(x(i), y(i));
       Me = Me + wt(i)*(N*N')*det(J);
    end 
end
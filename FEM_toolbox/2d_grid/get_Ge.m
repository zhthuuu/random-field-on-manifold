% gradient function
% varargin: {P, t, elementNo}
function Ge = get_Ge(varargin)
    Ge = zeros(4,4);
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
        gradN = get_gradN_Q4(x(i), y(i));
        B = J \ gradN;
        Ge = Ge + wt(i)*(B'*B)*det(J); 
    end
end
% gradient function
% varargin: {P, t, elementNo, normvecs}
function Ge = get_Ge(varargin)
    Ge = zeros(3);
    if nargin==3
        J = Jacobi_mat(varargin{1}, varargin{2}, varargin{3});
        gradN = get_gradN();
    elseif nargin==4 
        J = Jacobi_mat(varargin{1}, varargin{2}, varargin{3}, varargin{4});
        gradN = [get_gradN();
                 0, 0, 0];
    else
        disp('wrong input argument number!');
        return
    end
    B = J \ gradN;
    Ge = Ge + 1/2*(B'*B)*det(J); % weight = 1/6, 3 points, add equal 1/2
end
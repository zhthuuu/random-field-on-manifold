% varargin: {P, t, elementNo, normvecs}
function J = Jacobi_mat(varargin)
%     disp(varargin);
    connectivity = varargin{2}(varargin{3}, :);
    coord = varargin{1}(connectivity, :);
    gradN = get_gradN();
    if nargin==3
        J = gradN * coord;
    elseif nargin==4
        normvec = varargin{4}(varargin{3}, :);
        J = [gradN * coord; normvec];
    else
        disp("wrong input argument numbers");
        return
    end
end
% return the gradient of the shape function with grid mesh
function grad = get_gradN_Q4(x, y)
    grad = [-1/4*(1+y),-1/4*(1-y),1/4*(1-y),1/4*(1+y); ...
            1/4*(1-x),-1/4*(1-x),-1/4*(1+x),1/4*(1+x)];
%     grad = [-1/4*(1-y),1/4*(1-y),1/4*(1+y),-1/4*(1+y); ...
%             -1/4*(1-x),-1/4*(1+x),1/4*(1+x),1/4*(1-x)];
end
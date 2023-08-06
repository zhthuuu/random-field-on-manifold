% return the gradient of the shape function in original domain
function grad = get_gradN()
    grad = [-1, 1, 0;
            -1, 0, 1];
end
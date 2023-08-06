% gradient of shape function
function grad = get_gradN()
    grad = [-1, 1, 0, 0;
            -1, 0, 1, 0;
            -1, 0, 0, 1];

end
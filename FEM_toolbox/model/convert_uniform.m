% transform the Gaussian distribution to uniform distribution
function eta_uniform = convert_uniform(low, high, eta_norm)
    eta_uniform = normcdf(eta_norm, 0, 1); 
    eta_uniform = (high-low)*eta_uniform + low;
end

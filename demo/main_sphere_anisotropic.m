%% input parameter
clear; clc;
addpath ../FEM_toolbox/model
addpath ../FEM_toolbox/2d
addpath ../laplace_3d
l = 0.1; kappa = 1/l;  % the length scale
mu = 0; sigma = 1;  % the mean and standard deviation of gaussian field
nu = 1; d = 2; % the parameters in the SPDE
normconst = sigma^2*(4*pi)^(d/2)*gamma(nu+d/2)/gamma(nu);
normconst = normconst*l^(d-4); % alpha multiplied to the white noise vector
lambda = [1,0.01,0.01];

%% mesh
disp('reading mesh');
file = '../FEM_toolbox/geometry/sphere_in_box/sphere_in_box.msh';
[P,t]=loadfem(file);
[p_sphere, tri_sphere, tri_sphere_id, ~] = sphere_tri(P, t);
disp('Done reading mesh');

%% solve gradu
u1 = run_laplace3d(P, t, "left"); % notice that the folder is changed to 3d
u2 = run_laplace3d(P, t, "up");
u3 = run_laplace3d(P, t, "front");
global_gradu = get_vector_field(P, t, u1, u2, u3);
global_gradu.gradu1 = global_gradu.gradu1(tri_sphere_id, :);
global_gradu.gradu2 = global_gradu.gradu2(tri_sphere_id, :);
global_gradu.gradu3 = global_gradu.gradu3(tri_sphere_id, :);
[P, t] = transform_surfmesh(P, tri_sphere);
numNodes = length(P);
disp('Done solving laplace euqations');

%% solve R
addpath ../FEM_toolbox/2d % change the folder to 2d
[R, flag, transP] = get_precision_mat_anisotropy(kappa, P, t, normconst, lambda, global_gradu);
disp("Done calculating precision matrix Q");
g0 = normrnd(mu,sigma,numNodes,1); % the white noise vector following Gaussian distribution
eta0 = transP * (R \ g0); % the random field
patch('Faces',t,'Vertices',P, 'EdgeColor','none','FaceVertexCData',eta0,'FaceColor','interp');
axis equal
% writeVTK(P, t, eta0, "figures/GF_sphere.vtk", "2d");


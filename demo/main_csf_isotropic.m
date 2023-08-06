%% input parameter
clear; clc;
addpath ../FEM_toolbox/model
addpath ../FEM_toolbox/2d
l = 0.01; kappa = 1/l;  % the length scale
mu = 0; sigma = 1;  % the mean and standard deviation of gaussian field
nu = 1; d = 2; % the parameters in the SPDE
normconst = sigma^2*(4*pi)^(d/2)*gamma(nu+d/2)/gamma(nu);
normconst = normconst*l^(d-4); % alpha multiplied to the white noise vector

%% mesh
disp('reading mesh');
file = '../FEM_toolbox/geometry/ernie_csf/csf_ernie.stl';
msh = stlread(file);
P = msh.Points;
t = msh.ConnectivityList;
P = P/1000;
numNodes = length(P);
disp('Done reading mesh');

%% solve R
[R, flag, transP] = get_precision_mat_isotropy(kappa, P, t, normconst);
disp("Done calculating precision matrix Q");
g0 = normrnd(mu,sigma,numNodes,1); % the white noise vector following Gaussian distribution
eta0 = transP * (R \ g0) / 2.5; % the random field
patch('Faces',t,'Vertices',P, 'EdgeColor','none','FaceVertexCData',eta0,'FaceColor','interp');
axis equal
% writeVTK(P, t, eta0, "data/grf_csf_0.01_0.01_1.vtk", "2d");

%% estimate std
disp("start calculating std");
g = normrnd(0, 1, numNodes, 2000);
eta = transP * (R \ g);
% standard deviation of eta
eta_std = std(eta, 0, 2);
histogram(eta_std);

%% Normalization
eta_norm = (eta - repmat(mean(eta, 2), 1, sample_num))./repmat(std(eta, 0, 2), 1, sample_num);

%% Correlation coefficient
sample_num = 3000;
g = normrnd(0, 1, numNodes, sample_num); % generate 10000 random field samples
eta = transP * (R \ g);
clear g
eta_corr = corrcoef(eta');
idx = find(P(:,3) == max(P(:,3)));
disp('Finish calculation!');
patch('Faces',t,'Vertices',P, 'EdgeColor','none','FaceVertexCData',eta_corr(idx,:)','FaceColor','flat');
axis equal
caxis([0 1]);
% writeVTK(P, t, eta_corr(P(:,3)==max(P(:,3)),:), "ernie_gm/corr.vtk", "2d");

%% modify geometry
height = 0.001;
P_modified = modify_geometry(P, t, height, eta_norm(:, 1));
trisurf(t, P_modified(:,1), P_modified(:,2), P_modified(:,3));
axis equal
export_stl(P_modified, t, 'geometry/modified_csf.stl');

%% export vtk file
p1= P(t(:,1), :);
p2= P(t(:,2), :);
p3= P(t(:,3), :);
pcenter = (p1+p2+p3)/3;
writeVTK_vec(pcenter, global_gradu.gradu1, "data/gradu1.vtk");
writeVTK_vec(pcenter, global_gradu.gradu2, "data/gradu2.vtk");
writeVTK_vec(pcenter, global_gradu.gradu3, "data/gradu3.vtk");



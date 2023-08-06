% demo to generate isoptopic non-Gaussian random field on 2d manifold or 2d flat
% surface. Here we use a flat square.
clc; clear;
addpath ./FEM_toolbox/model
addpath ./FEM_toolbox/2d
seed = RandStream('mt19937ar', 'Seed', 1); RandStream.setGlobalStream(seed); %set seed
file = 'FEM_toolbox/geometry/square/square.stl'; % input brain tissue boundary mesh
% dir = 'data/'; mkdir(dir); % generated mesh folder
l = 0.1; % the coorrelation length
height = 10; % height = 2*mean(|x1-x2|), for the range [-height, +height]
N = 10; % number of generated meshes

%% preprocessing
kappa = 1/l;  
mu = 0; sigma = 1;  % the mean and standard deviation of gaussian field
nu = 1; d = 2; % the parameters in the SPDE
normconst = sigma^2*(4*pi)^(d/2)*gamma(nu+d/2)/gamma(nu);
normconst = normconst*l^(d-4); % alpha multiplied to the white noise vector
msh = stlread(file);
P = msh.Points;
t = msh.ConnectivityList;
numNodes = size(P, 1);
disp(['Done reading mesh ', file]);

%% solve SPDE
[R, flag, transP] = get_precision_mat_isotropy(kappa, P, t, normconst);  % the important matrix Q R
disp("Done calculating precision matrix Q");

% modify multiply geometries
g = normrnd(mu,sigma,numNodes,N); % the white noise vector following Gaussian distribution
eta = transP * (R \ g); % the random field
delta = 0.3;
direction = 'positive';
eta_beta = convert_beta(height, delta, eta, direction);

%% visualization
patch('Faces',t,'Vertices',P,'FaceVertexCData',eta_beta(:,1),'FaceColor','interp','EdgeColor', '#4DBEEE');
colorbar;


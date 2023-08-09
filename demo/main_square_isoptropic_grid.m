% demo to generate isoptopic non-Gaussian random field on 2d manifold or 2d flat
% surface. Here we use a flat square.
clc; clear;
addpath ../FEM_toolbox/model
addpath ../FEM_toolbox/2d_grid
seed = RandStream('mt19937ar', 'Seed', 1); RandStream.setGlobalStream(seed); %set seed

%% preprocessing
s = 100; % number of elements per edge
l = 0.1; % the coorrelation length
height = 10; % height = 2*mean(|x1-x2|), for the range [-height, +height]
N = 10; % number of samples
kappa = 1/l;  
mu = 0; sigma = 1;  % the mean and standard deviation of gaussian field
nu = 1; d = 2; % the parameters in the SPDE
normconst = sigma^2*(4*pi)^(d/2)*gamma(nu+d/2)/gamma(nu);
normconst = normconst*l^(d-4); % alpha multiplied to the white noise vector

%% generate grid mesh
[p, t, FIXEDNODES] = generate_grid_mesh(s);
% [p, t] = generate_mesh_test(20,20,1,1);

hold on
patch('Faces',t,'Vertices',p,'EdgeColor', '#4DBEEE');
% scatter(p(FIXEDNODES, 1), p(FIXEDNODES, 2), 'red');
hold off
numNodes = length(p);

%% solve SPDE
[R, flag, transP] = get_precision_mat_isotropy(kappa, p, t, normconst);  % the important matrix Q R
disp("Done calculating precision matrix Q");

% modify multiply geometries
g = normrnd(mu,sigma,numNodes,N); % the white noise vector following Gaussian distribution
eta = transP * (R \ g); % the random field
delta = 0.3;
direction = 'positive';
eta_beta = convert_beta(height, delta, eta, direction);

%% visualization
patch('Faces',t,'Vertices',p,'FaceVertexCData',eta(:,2),'FaceColor','flat','EdgeColor', 'white');
colorbar;

%% obtain samples
disp("Obtaining samples...");
sample_num = 3000;
g = normrnd(0, 1, numNodes, sample_num); % generate 10000 random field samples
eta = transP * (R \ g);
clear g
% normalization at each node

%% visualization of std (can observe boundary condition)
eta_std = std(eta, 0, 2);
trisurf(t, p(:,1), p(:,2), eta_std);colorbar;

%% validation via comparison of covariance functions
reference = 51;
p_line = find(p(:,2)==0.5);
% scatter(p(p_line,1), p(p_line,2));
eta_cov = cov(eta(p_line,:)');              
x_point = vecnorm(p(p_line, :)-p(p_line(reference),:), 2, 2);
y_point = eta_cov(reference,:);
x_matern = linspace(0, 0.5, 101);
y_matern = kappa*abs(x_matern).*besselk(nu, kappa*abs(x_matern));
y_matern(1) = 1;
figure
scatter(x_point, y_point);
hold on
plot(x_matern, y_matern, '--b','LineWidth', 2);
xlabel("distance");
ylabel("cross-covariance");
legend("Computational result", "Matern covariance function", 'LineWidth', 1) 



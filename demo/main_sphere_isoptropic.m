%% input parameter
clear; clc;
seed = RandStream('mt19937ar', 'Seed', 1); RandStream.setGlobalStream(seed); %set seed
addpath ../FEM_toolbox/model
addpath ../FEM_toolbox/2d
file = '../FEM_toolbox/geometry/sphere/sphere.stl'; % input brain tissue boundary mesh
l = 0.1;  % the length scale
N = 10;
height = 1;

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
patch('Faces',t,'Vertices',P,'FaceVertexCData',eta_beta(:,1),'FaceColor','interp','EdgeColor', 'none');
colorbar;
axis equal

%% estimate std
disp("start calculating std");
g = normrnd(0, 1, numNodes, 10000);
eta = transP * (R \ g);
% standard deviation of eta
eta_std = std(eta, 0, 2);
histogram(eta_std);
% trisurf(t, P(:,1), P(:,2), P(:,3),eta_std);
% axis equal
% caxis([0.5,1.5]);

%% sphere projection
% calculate longitude and latitude
lan = zeros(length(P),1);
lon = zeros(length(P),1);
for i=1:length(P)
   x = P(i,1);
   y = P(i,2);
   z = P(i,3);
   lan(i) = atan(z/norm([x,y]));
   if x>=0 && y >0
       lon(i) = atan(x/y);
   elseif x<0 && y>0
       lon(i) = atan(x/y) + 2*pi;
   else
       lon(i) = atan(x/y) + pi;       
   end    
end
lan = lan * 180 / pi;
lon = lon * 180 / pi;
% interpolate using griddata
[interpx, interpy]=meshgrid(0:0.2:360, -90:0.2:90);
Vq = griddata(lon, lan, eta_std, interpx, interpy,'linear');
% using mapping toolbox for projection
[~,Rmap] = egm96geoid;
Rmap.RasterSize = size(Vq);
axesm eckert4
geoshow(Vq,Rmap,'DisplayType','surface')
cb = colorbar('southoutside');
cb.Label.String = 'standard deviation';
caxis([0.8 1.2]);

%% Normalization
disp("Obtaining samples...");
sample_num = 3000;
g = normrnd(0, 1, numNodes, sample_num); % generate 10000 random field samples
eta = transP * (R \ g);
clear g
% normalization at each node

%% Correlation coefficient
disp("Computing correlation coefficients...");
eta_corr = corrcoef(eta');
% eta_cov = cov(eta');
disp('Finish calculation!');
% plot
trisurf(t, P(:,1), P(:,2), P(:,3), eta_corr(1,:)');
% patch('Faces',t,'Vertices',p, 'EdgeColor','none','FaceVertexCData',eta_corr(1000,:)','FaceColor','flat');
axis equal
% pdeplot(model, 'XYData', eta_corr, 'ColorMap','jet');
caxis([0 1]);
% writeVTK(P, t, eta_corr(P(:,3)==max(P(:,3)),:), "ernie_gm/corr.vtk", "2d");

%% modify geometry
height = 0.001;
P_modified = modify_geometry(P, t, height, eta_norm(:, 1));
trisurf(t, P_modified(:,1), P_modified(:,2), P_modified(:,3));
axis equal
export_stl(P_modified, t, 'geometry/modified_csf.stl');

%% plot
len = 30;
reference = 1;
r = 1;
p_line = find_point_line(P, 0, 0, 0, r, len);
% scatter3(P(p_line,1), P(p_line,2), P(p_line,3));
eta_cov = cov(eta(p_line,:)');              
x_point = linspace(0, 1, len) * pi * r;
y_point = eta_cov(reference,:);
x_matern = linspace(0, 1, 201) * pi * r;
% y_line2 = exp(-abs(x_line)/(l));
% nu = 1; kappa = 10;
y_matern = kappa*abs(x_matern).*besselk(nu, kappa*abs(x_matern));
y_matern(1) = 1;
% y_line = exp(-(x_line.*x_line)/(2*l*l));
% y_line = 2^(1-nu)/gamma(nu)*(x_line/l).^nu.*besselk(nu, x_line/l);
figure
plot(x_point, y_point, '-ro','LineWidth', 2, 'MarkerSize', 7);
hold on
plot(x_matern, y_matern, '--b','LineWidth', 2);
% hold on
% plot(x_line, y_line2);
xlabel("distance");
ylabel("cross-covariance");
legend("Computational result", "Matern covariance", 'LineWidth', 1) 
ylim([-0.02,1]);

%% export vtk file
p1= P(t(:,1), :);
p2= P(t(:,2), :);
p3= P(t(:,3), :);
pcenter = (p1+p2+p3)/3;
writeVTK(P, t, eta_norm(:,1), "geometry/eta_02.vtk", "2d");
writeVTK(P, t, eta_cov(1,:)', "geometry/corr_02.vtk", "2d");

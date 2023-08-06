% use the Matlab mapping toolbox to project the values on sphere onto the 2d plane
function sphere_projection(P, t, eta, title)
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
  [interpx, interpy]=meshgrid(0:0.1:360, -90:0.1:90);
  Vq = griddata(lon, lan, eta, interpx, interpy,'nearest');
  % using mapping toolbox for projection
  [~,Rmap] = egm96geoid;
  Rmap.RasterSize = size(Vq);
  axesm eckert4
  geoshow(Vq,Rmap,'DisplayType','surface')
  cb = colorbar('southoutside');
  cb.Label.String = title;
  % caxis([0.8 1.2]);
end
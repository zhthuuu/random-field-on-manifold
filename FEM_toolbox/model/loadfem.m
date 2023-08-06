function [p,te2p,reg,t2p,reg3]=loadfem(filename)
delimiter = ' ';
startRow = 5;
endRow = 5;
formatSpec = '%f%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow-1, 'ReturnOnError', false);
fclose(fileID);
npt = dataArray{:, 1};
clearvars   delimiter startRow endRow formatSpec fileID dataArray ans;
delimiter = ' ';
startRow = 6;
endRow = 5+npt;
formatSpec = '%*s%f%f%f%*s%*s%*s%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow-1, 'ReturnOnError', false);
fclose(fileID);
p(:,1) = dataArray{:, 1};
p(:,2) = dataArray{:, 2};
p(:,3) = dataArray{:, 3};
%% Clear temporary variables
clearvars   delimiter startRow endRow formatSpec fileID dataArray ans;
delimiter = ' ';
startRow = 8+npt;
endRow = 8+npt;
formatSpec = '%f%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow-1, 'ReturnOnError', false);
fclose(fileID);
nelem = dataArray{:, 1};
clearvars   delimiter startRow endRow formatSpec fileID dataArray ans;


delimiter = ' ';
startRow = 9+npt;
endRow = 9+npt+nelem;
formatSpec = '%*s%f%*s%f%*s%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, nelem, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
elemtype = dataArray{:, 1};
reg= dataArray{:, 2};
te2p(:,1) = dataArray{:, 3};
te2p(:,2) = dataArray{:, 4};
te2p(:,3) = dataArray{:, 5};
te2p(:,4) = dataArray{:, 6};
clearvars   delimiter startRow formatSpec fileID dataArray ans;
te2p=te2p';
t2p=te2p(1:3,elemtype==2);
reg3=reg(elemtype==2);
reg=reg(elemtype==4);
x=unique(reg(:));
reg2=reg(:);
length(x)
for i=1:length(x)
    reg2(reg==x(i))=i;
end
reg=reg2;
te2p=te2p(1:4,elemtype==4)';
end

function tri=surftri(p,t)
%SURFTRI Find surface triangles from tetrahedra mesh
%   TRI=SURFTRI(P,T)

%   Copyright (C) 2004-2012 Per-Olof Persson. See COPYRIGHT.TXT for details.

% Form all faces, non-duplicates are surface triangles
faces=[t(:,[1,2,3]);
       t(:,[1,2,4]);
       t(:,[1,3,4]);
       t(:,[2,3,4])];
node4=[t(:,4);t(:,3);t(:,2);t(:,1)];
faces=sort(faces,2);
[foo,ix,jx]=unique(faces,'rows');
vec=histc(jx,1:max(jx));
qx=find(vec==1);
tri=faces(ix(qx),:);
node4=node4(ix(qx));

% Orientation
v1=p(tri(:,2),:)-p(tri(:,1),:);
v2=p(tri(:,3),:)-p(tri(:,1),:);
v3=p(node4,:)-p(tri(:,1),:);
ix=find(dot(cross(v1,v2,2),v3,2)>0);
tri(ix,[2,3])=tri(ix,[3,2]);
end


function export_stl(P, t, output)
    fv.vertices = P;
    fv.faces = t;
    % stlwrite('tritext.stl',fv,'mode','ascii','triangulation','delaunay')
    stlwrite(output,fv,'mode','binary');
end
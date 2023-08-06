% write .vtk file (2d or three 3d)
function writeVTK(P, t, eta, name_input, dimension)
    vtkfile = fopen(name_input, 'w');
    num_p = size(P, 1);
    num_t = size(t, 1);
%     disp(connectivity(1:10, :));
%     type_vec = ones(1, num_t) * 10;
    fprintf(vtkfile, '%s\n', "# vtk DataFile Version 2.0");
    fprintf(vtkfile, '%s\n', "data from MATLAB");
    fprintf(vtkfile, '%s\n', "ASCII");
    fprintf(vtkfile, '%s\n', "DATASET UNSTRUCTURED_GRID");
    fprintf(vtkfile, '%s %d %s\n', "POINTS", num_p, "double");
    fprintf(vtkfile, '%.9f %.9f %.9f\n', P');
    if dimension == "3d"
        connectivity = [ones(num_t,1)*4, t-1]';
        fprintf(vtkfile, '%s %d %d\n', "CELLS", num_t, 5 * num_t);
        fprintf(vtkfile, '%d %d %d %d %d\n', connectivity);
        fprintf(vtkfile, "%s %d\n", "CELL_TYPES", num_t);
        fprintf(vtkfile, "%d\n", ones(1, num_t) * 10);
    elseif dimension == "2d"
        connectivity = [ones(num_t,1)*3, t-1]';
        fprintf(vtkfile, '%s %d %d\n', "CELLS", num_t, 4 * num_t);
        fprintf(vtkfile, '%d %d %d %d\n', connectivity);
        fprintf(vtkfile, "%s %d\n", "CELL_TYPES", num_t);
        fprintf(vtkfile, "%d\n", ones(1, num_t) * 5);
    else
        disp("Specify the dimension with 2d or 3d!");
        return;
    end
    fprintf(vtkfile, "%s %d\n" ,"POINT_DATA", num_p);
    fprintf(vtkfile, "%s %d\n" ,"SCALARS eta double", 1);
    fprintf(vtkfile, "%s\n" ,"LOOKUP_TABLE table1");
    fprintf(vtkfile, "%.6f\n", eta');
    fclose(vtkfile);
    disp("Done writing file " + name_input);
end
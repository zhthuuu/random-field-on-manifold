function writeVTK_vec(P, vec, name_input)
    disp("Now write vtk file...");
    vtkfile = fopen(name_input, 'w');
    num_p = size(P, 1);
%     num_t = size(t, 1);
    fprintf(vtkfile, '%s\n', "# vtk DataFile Version 2.0");
    fprintf(vtkfile, '%s\n', "data from MATLAB");
    fprintf(vtkfile, '%s\n', "ASCII");
    fprintf(vtkfile, '%s\n', "DATASET UNSTRUCTURED_GRID");
    fprintf(vtkfile, '%s %d %s\n', "POINTS", num_p, "double");
    fprintf(vtkfile, '%.9f %.9f %.9f\n', P');
%     connectivity = [ones(num_t,1)*3, t-1]';
%     fprintf(vtkfile, '%s %d %d\n', "CELLS", num_t, 4 * num_t);
%     fprintf(vtkfile, '%d %d %d %d\n', connectivity);
%     fprintf(vtkfile, "%s %d\n", "CELL_TYPES", num_t);
%     fprintf(vtkfile, "%d\n", ones(1, num_t) * 5);
    fprintf(vtkfile, "%s %d\n" ,"POINT_DATA", num_p);
    fprintf(vtkfile, "%s\n" ,"VECTORS gradu float");
    fprintf(vtkfile, "%.6f %.6f %.6f\n", vec');
    fclose(vtkfile);
    disp("Finish writing file " + name_input);
end
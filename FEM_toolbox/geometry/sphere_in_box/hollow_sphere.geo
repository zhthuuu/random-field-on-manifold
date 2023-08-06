/*********************************************************************
 *
 *  Gmsh tutorial 7
 *
 *  Background mesh
 *
 *********************************************************************/

// Characteristic lengths can be specified very accuractely by providing a
// background mesh, i.e., a post-processing view that contains the target mesh
// sizes.

// Merge the first tutorial
// Merge "/Users/haozhang/Desktop/hollow_sphere/box.stl";
// Merge "/Users/haozhang/Desktop/hollow_sphere/shpere.stl";
Merge "box.stl";
Merge "shpere.stl";
Surface Loop(1) = {1};
Surface Loop(2) = {2};
Volume(1) = {1, 2};

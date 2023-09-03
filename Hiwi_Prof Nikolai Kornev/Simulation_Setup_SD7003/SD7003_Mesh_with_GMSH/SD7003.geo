
Include "airfoil.geo";
//+


// Define meshsize 
ms = 0.000001;

//Domain Variables

ymax = 4;
xmax = 10;

//Number of Nodes
n_Inlet = 420;
n_UpperAerofoil = 700;
n_LowerAerofoil = 600;
n_Vertical = 400;
n_Wake = 2000;


I_Bump = 0.6;
UA_Progression = 1.;
LA_Progression = 1;
V_Progression = 0.975;
W_Progression = 1;

// Spanwise (Extrusion parameter) : 0.25C

h = 0.0625; 

// Domain creation

Point(59) = {-0.5, ymax, -0, ms};
Point(60) = {-0.5, -ymax, -0, ms};
Point(61) = {1, -ymax, -0, ms};
Point(62) = {1, ymax, -0, ms};
Point(63) = {xmax, ymax, -0, ms};
Point(64) = {xmax, -ymax, -0, ms};
Point(65) = {xmax, 0, 0, ms};


//Inlet

Circle(2) = {60, 29, 59};


//Line creation

Line(3) = {59, 3};
Line(4) = {32, 60};
Line(5) = {59, 62};
Line(6) = {60, 61};
Line(7) = {62, 63};
Line(8) = {61, 64};
Line(9) = {65, 64};
Line(10) = {65, 63};
Line(11) = {58, 62};
Line(12) = {58, 61};
Line(13) = {58, 65};


//Meshing -Transfinite Curve, Progression close to 1 gives good mesh, eg. .85 or 1.1


Transfinite Curve {2, 101} = n_Inlet Using Bump I_Bump;
Transfinite Curve {5, 100} = n_UpperAerofoil Using Progression UA_Progression;
Transfinite Curve {6, 200} = n_LowerAerofoil Using Progression LA_Progression;
Transfinite Curve {7, 13, 8} = n_Wake Using Progression W_Progression;
Transfinite Curve {3, -11, -10, -4, -12, -9} = n_Vertical Using Progression V_Progression; //Keep it 0.85 it gives optimum mesh


//Meshing  (Loops and Surfaces)

Curve Loop(1) = {2, 3, -101, 4};
Plane Surface(1) = {1};
Curve Loop(2) = {3, 100, 11, -5};
Plane Surface(2) = {2};
Curve Loop(3) = {11, 7, -10, -13};
Plane Surface(3) = {3};
Curve Loop(4) = {12, 8, -9, -13};
Plane Surface(4) = {4};
Curve Loop(5) = {4, 6, -12, 200};
Plane Surface(5) = {5};

//Meshing -Transfinite Surfaces

Transfinite Surface {1};
Transfinite Surface {2};
Transfinite Surface {3};
Transfinite Surface {4};
Transfinite Surface {5};


//Meshing -Recombine Surfaces (Structure mesh)

Recombine Surface {1, 2, 3, 4, 5};

//Extrude 

Extrude {0, 0, h} {
  Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; Layers {1}; Recombine;
}

//Physical Surfaces and Volume

//+
Show "*";
Physical Surface("Inlet") = {257, 243, 209, 301, 279};
Physical Surface("Outlet") = {261, 283};
Physical Surface("Back") = {1, 2, 3, 4, 5};
Physical Surface("Front") = {222, 244, 266, 288, 310};
Physical Surface("Aerofoil") = {235, 217, 309};

Physical Volume("Fluid") = {1, 2, 3, 4, 5};

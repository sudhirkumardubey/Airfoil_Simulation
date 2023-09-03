Include "airfoil.geo";

//+
BSpline(1) = {29, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 57, 58, 56, 55, 54, 53, 52, 51, 50, 49, 48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29};
//+

gridsize = 0.00025;
ymax = 5;
xmax = 20;
n_inlet = 80;
n_vertical = 110;
r_vertical = 1;
n_airfoil = 70;
n_wake = 900;
r_wake = 1;

//+
Point(59) = {-0.5, ymax, -0, gridsize};
//+
Point(60) = {-0.5, -ymax, -0, gridsize};
//+
Point(61) = {1, -ymax, -0, gridsize};
//+
Point(62) = {1, ymax, -0, gridsize};
//+
Point(63) = {xmax, ymax, -0, gridsize};
//+
Point(64) = {xmax, -ymax, -0, gridsize};
//+
Point(65) = {xmax, 0, 0, gridsize};
//+
Circle(2) = {60, 29, 59};
//+
Line(3) = {59, 3};
//+
Line(4) = {32, 60};
//+
Line(5) = {59, 62};
//+
Line(6) = {60, 61};
//+
Line(7) = {62, 63};
//+
Line(8) = {61, 64};
//+
Line(9) = {65, 64};
//+
Line(10) = {65, 63};
//+
Line(11) = {58, 62};
//+
Line(12) = {58, 61};
//+
Line(13) = {58, 65};

//+
Split Curve(1) {3, 32};
//+
Split Curve(14) {3, 58};

//+
Transfinite Curve {2, 15} = n_inlet Using Bump 0.45;
//+
Transfinite Curve {3, 11, 10, 4, 12, 9} = n_vertical Using Progression r_vertical;
//+
Transfinite Curve {17, 16} = n_airfoil Using Bump 0.045;
//+
Transfinite Curve {5, 6} = n_airfoil Using Bump 2;
//+
Transfinite Curve {13} = n_wake Using Progression r_wake;
//+
Transfinite Curve {7, 8} = n_wake Using Bump 1;

//+
Curve Loop(1) = {2, 3, -15, 4};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {3, 16, 11, -5};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {11, 7, -10, -13};
//+
Plane Surface(3) = {3};
//+
Curve Loop(4) = {4, 6, -12, 17};
//+
Plane Surface(4) = {4};
//+
Curve Loop(5) = {12, 8, -9, -13};
//+
Plane Surface(5) = {5};

//+
Transfinite Surface {1};
//+
Transfinite Surface {2};
//+
Transfinite Surface {3};
//+
Transfinite Surface {5};
//+
Transfinite Surface {4};
//+
Recombine Surface {1, 2, 3, 5, 4};

//+
Extrude {0, 0, 0.2} {
  Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5}; Layers {1}; Recombine;
}
//+

//+
Physical Surface("Inlet", 141) = {26, 60, 74, 96, 118};
//+
Physical Surface("Outlet", 142) = {78, 122};
//+
Physical Surface("Aerofoil", 143) = {104, 52, 34};
//+
Physical Surface("FrontandBack", 144) = {83, 127, 105, 39, 61, 1, 2, 3, 5, 4};
//+
Physical Volume("Fluid", 140) = {1, 2, 3, 5, 4};











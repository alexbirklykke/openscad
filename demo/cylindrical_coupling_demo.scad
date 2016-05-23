
use <../cylindrical_coupling.scad>

$fn=100;
h = 40; 
r1 = 20;
r2 = 10;
mt = 2; 

difference() {
    cylindrical_coupling(h=h, r1 =20, r2 = 10, shape=0.4, kernel="tanh",slices=50);
    translate([0,0,-1])cylindrical_coupling(h=h+2, r1 =20-mt, r2 = 10-mt, shape=0.4, kernel="tanh",slices=50);
}




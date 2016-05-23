
use <../funnel.scad>

$fn = 100;
h = 30;
r1 = 34.5;
r2 = 15;
shape = 0.45;
mt = 3;


difference() {

    funnel(h,r1+mt,r2+mt,shape=shape);
    translate([0,0,-1])funnel(h+2,r1,r2,shape=shape);
}


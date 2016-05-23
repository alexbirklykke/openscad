

module funnel(h,r1,r2,shape=1, slices=100) {

     // Local functions
    log10 = 2.3025850929940459;
    function log_e(x) = log(x)*log10;
    function funnel_func(a,x) = -0.5*a*log_e(x*x);
    
    // Normalize h re. r1
    r3=r1-r2;
    s = h/r3;
    h_norm = s*1;
 
    // Calc normalised boundaries
    x_max = 1;
    x_min = exp(-h_norm/shape);
    
    // Calc normalised range
    x_span = x_max - x_min;
    x_step = x_span/slices;
    x_norm = [for (i = [x_min:x_step:x_max+x_step]) i];
     
    // Calc corresponding unnormalized range 
    r_step = r3/slices;
    r = [for (i = [0:r_step:r3]) i+r2];

    // Calc funnel points and reverse normalization
    funnel_points = [for (i = [0:slices-1]) [r[i], r3*funnel_func(shape,x_norm[i])]];
    points = concat(funnel_points, [[r1,0],[0,0],[0,h]]);

    // Draw
    rotate_extrude()
    polygon(points);
             

}

// Example
//h = 30;
//r1 = 34.5;
//r2 = (32-1.9)/2;
//shape = 0.45;
//mt = 3;
//
//*difference() {
//    cylinder(h=100, r=75/2);
//    translate([0,0,-2])cylinder(h=104, r=75/2-2.5);
//}
//
//*translate([0,0,h])difference() {
//    cylinder(h=200, r=r2+mt);
//    translate([0,0,-2])cylinder(h=204, r=r2);
//}
//
//difference() {
//
//    funnel(h,r1+mt,r2+mt,shape=shape);
//    funnel(h,r1,r2,shape=shape);
//    cylinder(h=2*h,r=r2);
//    translate([0,0,-mt]) cylinder(h=mt, r=r1);   
//   
//}



   



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



   

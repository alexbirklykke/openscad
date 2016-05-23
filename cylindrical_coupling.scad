

module cylindrical_coupling(h,r1,r2,shape=0.5, kernel="sigmoid", slices=100) {
    // Method:
    //  1. Calculate transition polygon using the selected kernel function
    //  2. Scale to desired size
    
    // Kernels
    function sigmoid(a,x) =-0.5+ 1 / (1+exp(-a*x));
    function tanh(a,x) = (1-exp(-2*a*x)) /(1+exp(-2*a*x));
    function nonlinear1(a,x) = a*x/sqrt(1+pow(a*x,2));
    function nonlinear2(a,x) = a*x/(1+abs(a*x));
    function linear(a,x) = a*x;
    
    // Select kernel
    function shape_func(a,x) = 
        (kernel=="sigmoid") ? sigmoid(a,x) : 
            (kernel=="tanh") ? tanh(a,x) : 
                (kernel=="linear") ? linear(a,x)  :
                    (kernel=="nonlinear1") ? nonlinear1(a,x) :
                        (kernel=="nonlinear2") ? nonlinear2(a,x) :
                            sigmoid(a,x); echo("WARNING: Unknown kernel. Using sigmoid");
              
    // Draw relative to x=[-10,10]
    x_min = -10;
    x_max = 10;
    x_span = x_max - x_min;
    x_step = x_span / slices;
    x = [for (i=[x_min:x_step:x_max+x_step]) i];

    // Derive y range
    y_max = shape_func(shape, x_max+x_step);
    y_min = shape_func(shape, x_min);
    y_span = y_max - y_min;
    
    // Calc scaling parameters
    y_scale = 1/y_span; 
    h_scale = h/x_span;
    L = r2-r1;
    
    // Generate polygon
    reducer_points = [for (i = [0:slices]) [r1+0.5*L+L*y_scale*shape_func(shape,x[i]),x[i]]];
    points = concat(reducer_points, [[0,x_max],[0,x_min]]);

    // Draw
    rotate_extrude()
    scale([1,h_scale,1])
    translate([0,x_max,0])polygon(points);
             
}

// Example
//$fn=100;
//h = 40; 
//cylindrical_coupling(h=h, r1 =20, r2 = 10, shape=0.4, kernel="tanh");
//%translate([0,0,h])cylinder(h=100,r=10);
//%translate([0,0,-100])cylinder(h=100,r=20);
//


   

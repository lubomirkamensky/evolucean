cover_total_height = 45;
cover_total_diameter = 150;
rate = cover_total_height/(cover_total_diameter*0.3);
cylinder_height = cover_total_height*rate;
fudge = 1;
$fn = 128;

difference() {
	union() {
		difference() {
			cover_shape(cylinder_height,cover_total_diameter);
			translate([0,0,-2.1]) cover_shape(cylinder_height-2,cover_total_diameter-2);
			rotate([90,0,0])  
				scale([1, rate, 1])
					cylinder(d=(2*cylinder_height)-4,h=cover_total_diameter,center = true);
		}
    	for (i = [36,144,216,324]) {
    		rotate([0, 0, i]) 
    			translate([0,127/2,0])
    				cover_leg();   				
    		}

    	for (i = [36,144,216,324]) {
    		rotate([0, 0, i]) 
    			translate([0,127/2,2])
    				rotate([90, 0, 0])
    					difference() {
    							cylinder(d=9,h=7,center=true);
    							cylinder(d=6,h=7+fudge,center=true);
    						}
    	}
	}
	for (i = [36,144,216,324]) {
		rotate([0, 0, i]) 
			translate([0,127/2,2])
				rotate([90, 0, 0])
					difference() {
						cylinder(d=6,h=7+fudge,center=true);
    				}
	}
	for (i = [48,60,72,84,96,108,120,132,228,240,252,264,276,288,300,312]) {
		rotate([0, 0, i]) 
			translate([0,127/2,2])
				rotate([90, 0, 0])
					difference() {
						cylinder(d=10,h=50,center=true);
    				}
	}
	translate([0,0,-50]) cylinder(d=cover_total_diameter,h=100,center=true);
	translate([0,47,0]) cube([20,2,100],center=true);
	translate([-100,50,0]) cube([100,95,40],center=true);
	//translate([-100,50,0]) rotate([0,90,0]) scale([1/2,1,1]) cylinder(d=95,h=100,center=true);
}

module cover_shape(cylinder_height,cover_total_diameter) {
	intersection() {
	hull() {
		intersection() {
				rotate([90,0,0])  
					scale([1, rate, 1])
						cylinder(d=cover_total_diameter*0.6,h=cover_total_diameter,center = true);
				cylinder(d=cover_total_diameter,h=cover_total_diameter,center = true);
			}
			scale([1, 1, 4/15])
				sphere(d = cover_total_diameter);
			translate([0,50,0])
				rounded_cylinder(r=cover_total_diameter/7,h=cover_total_height,n=4);
			rounded_cylinder(r=0.44*cover_total_diameter,h=0.67*cylinder_height,n=4);
	}
	translate([0, 0, cover_total_diameter/2]) 
		cube(cover_total_diameter, center = true);
	}
}

module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}

module cover_leg() {
	rotate([0,0,270])
	difference() {
		cylinder(d=7,h=cover_total_height*0.77);
		translate([-30+3.5,0,cover_total_height*0.77])
			rotate(a=[-90,0,0])
				linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
					polygon(points=[[0,0],[30,0],[0,10]], paths=[[0,1,2]]);
	}
}

module rcube(size, radius) {
    hull() {
        translate([radius[0], radius[0]]) cylinder(r = radius[0], h = size[2]);
        translate([size[0] - radius[1], radius[1]]) cylinder(r = radius[1], h = size[2]);
        translate([size[0] - radius[2], size[1] - radius[2]]) cylinder(r = radius[2], h = size[2]);
        translate([radius[3], size[1] - radius[3]]) cylinder(r = radius[3], h = size[2]);
    }
}
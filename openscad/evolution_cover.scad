sphere_height = 20;
cylinder_height = 45;
cover_total_diameter = 150;
fudge = 1;
$fn = 128;

//rotate ([180,0,0])

difference() {
	union() {
		difference() {
			cover_shape(sphere_height,cylinder_height,cover_total_diameter);
			translate([0,0,-2.1]) cover_shape(sphere_height-2,cylinder_height-2,cover_total_diameter-2);
			rotate([90,0,0])  
				scale([1, 3/4, 1])
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
}


module cover_shape(sphere_height,cylinder_height,cover_total_diameter) {
	intersection() {
	hull() {
		intersection() {
				rotate([90,0,0])  
					scale([1, 3/4, 1])
						cylinder(d=2*cylinder_height,h=cover_total_diameter,center = true);
				cylinder(d=cover_total_diameter,h=cover_total_diameter,center = true);
			}
			scale([1, 1, (2*sphere_height)/cover_total_diameter])
				sphere(d = cover_total_diameter);
			rounded_cylinder(r=cylinder_height*1/2,h=cylinder_height*3/4,n=4);
			rounded_cylinder(r=65,h=25,n=4);
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
		cylinder(d=7,h=53,center=true);
		translate([-30+3.5,0,53/2])
			rotate(a=[-90,0,0])
				linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
					polygon(points=[[0,0],[30,0],[0,10]], paths=[[0,1,2]]);
	}
}


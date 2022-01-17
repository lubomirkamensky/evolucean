cover_total_height = 45;
cover_total_diameter = 150;
rate = cover_total_height/(cover_total_diameter*0.3);
cylinder_height = cover_total_height*rate;
fudge = 1;
$fn = 128;


	intersection() {
	hull() {
		intersection() { //shaping the holes on the head and tale
				rotate([90,0,0])  
					scale([1, rate, 1])
						cylinder(d=cover_total_diameter*0.6,h=cover_total_diameter,center = true);
				cylinder(d=cover_total_diameter,h=cover_total_diameter,center = true);
			}
			scale([1, 1, 4/15])
				sphere(d = cover_total_diameter); // the basic shape
			translate([0,50,0])
				rounded_cylinder(r=cover_total_diameter/7,h=cover_total_height,n=4);  //shaping the top
			rounded_cylinder(r=0.44*cover_total_diameter,h=0.67*cylinder_height,n=4); //shaping the main
	}
	translate([0, 0, cover_total_diameter/2]) 
		cube(cover_total_diameter, center = true);  //keep just the upper half of the model
	}


translate([0,50,45])
	scale([1, 4/5, 1/3])
		sphere(d=45); 

module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}
sphere_height = 20;
cylinder_height = 35;
total_diameter = 150;
$fn = 128;

intersection() {
hull() {
	intersection() {
			rotate([90,0,0])  
				scale([1, 3/4, 1])
					cylinder(d=2*cylinder_height,h=total_diameter,center = true);
			cylinder(d=total_diameter,h=total_diameter,center = true);
		}
		scale([1, 1, (2*sphere_height)/total_diameter])
			sphere(d = total_diameter);
		//rounded_cylinder(r=cylinder_height,h=cylinder_height*3/4,n=4);
		scale([1, 1, 2/3])
			sphere(d = total_diameter*3/4);

}
translate([0, 0, total_diameter/2]) 
	cube(total_diameter, center = true);
}
module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}


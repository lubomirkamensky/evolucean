fudge = 1;
$fn = 128;

intersection() {
	scale([1, 4/5, 1/3])
		sphere(d=45); 
	translate([0, 0, 45/2]) 
		cube(45, center = true);  //keep just the upper half of the model
}
translate([50, 0, 0]) 
	scale([1, 4/5, 1])
		cylinder(d=45,h=8); 
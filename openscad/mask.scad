fudge = 1;
$fn = 64;

difference() {
	scale([1, 1, 7/15]) sphere(d=15,center=true);
	translate([0, 0, -15/2])  cube(15, center = true);  //keep just the upper half of the model
	cylinder(d=8,h=5,center=true);
}
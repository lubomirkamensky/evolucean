holder_diameter = 150;
$fn = 128;

difference() {
	union() {
		scale([1, 1, 1/5]) sphere(d=holder_diameter,center=true);
		translate([0,0,-8]) cylinder(d=holder_diameter,h=15,center = true);
	}

	translate([-40,40,15]) cube([150,150,50],center=true);
	translate([-25,20,-5]) cube([150,150,10],center=true);
	cylinder(d=4,h=40,center = true);
	cylinder(d=16,h=25,center = true);
}
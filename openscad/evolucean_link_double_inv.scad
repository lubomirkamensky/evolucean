use <evolution_ball.scad>
use <evolucean_socket.scad>

$fn = 32;
difference() {
	union() {
		rotate([45,0,0]) socket(stem_length = 7);
		rotate([-45,0,0]) socket(stem_length = 7);
		rotate([180,0,0]) ball();
	}
	translate([0,0,-4])  cube([15,2,4],center = true);
	translate([0,0,-4]) rotate([0,0,90]) cube([15,2,4],center = true);
	translate([0,0,-6])  cube([15,4,2],center = true);
	translate([0,0,-6]) rotate([0,0,90]) cube([15,4,2],center = true);
}






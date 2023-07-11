use <evolution_ball.scad>
use <evolucean_socket.scad>

fudge = 1;
$fn = 32;

union() {
	rotate([45,0,0]) difference() {
		ball(stem_length = 7);
		translate([0,0,11])  cube([15,2,4],center = true);
		translate([0,0,11]) rotate([0,0,90]) cube([15,2,4],center = true);
		translate([0,0,13])  cube([15,4,2],center = true);
		translate([0,0,13]) rotate([0,0,90]) cube([15,4,2],center = true);
	}

	rotate([-45,0,0]) difference() {
		ball(stem_length = 7);
		translate([0,0,11])  cube([15,2,4],center = true);
		translate([0,0,11]) rotate([0,0,90]) cube([15,2,4],center = true);
		translate([0,0,13])  cube([15,4,2],center = true);
		translate([0,0,13]) rotate([0,0,90]) cube([15,4,2],center = true);
	}

	rotate([180,0,0]) socket();
}




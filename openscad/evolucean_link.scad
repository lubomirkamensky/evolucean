use <evolution_ball.scad>
use <evolucean_socket.scad>

fudge = 1;
$fn = 32;

rotate([180,0,0])

difference() {
	union() {
		ball(stem_length = 7);
		rotate([180,0,0]) socket();
	}
	translate([0,0,11])  cube([15,2,4],center = true);
	translate([0,0,11]) rotate([0,0,90]) cube([15,2,4],center = true);
	translate([0,0,13])  cube([15,4,2],center = true);
	translate([0,0,13]) rotate([0,0,90]) cube([15,4,2],center = true);
	translate([0,0,4])  cube([15,2,4],center = true);
	translate([0,0,4]) rotate([0,0,90]) cube([15,2,4],center = true);
}



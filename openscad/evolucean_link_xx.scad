use <evolucean_socket.scad>

$fn = 32;

difference() {
	union() {
		socket(stem_length = 7);
		rotate([180,0,0]) socket();
	}
	translate([0,0,4])  cube([15,2,4],center = true);
	translate([0,0,4]) rotate([0,0,90]) cube([15,2,4],center = true);
}






use <evolution_ball.scad>
use <evolucean_socket.scad>

fudge = 1;
$fn = 32;

evolucean_link(a=7);
translate([25,0,0]) evolucean_link(a=15);
translate([50,0,0]) evolucean_link(a=18);

module evolucean_link(a) {
	difference() {
		ball(stem_length=a);
		translate([0,0,a+4])  cube([15,2,4],center = true);
		translate([0,0,a+4]) rotate([0,0,90]) cube([15,2,4],center = true);
		translate([0,0,a+6])  cube([15,4,2],center = true);
		translate([0,0,a+6]) rotate([0,0,90]) cube([15,4,2],center = true);
		translate([0,0,a/2+a/14])  cube([15,2,4],center = true);
		translate([0,0,a/2+a/14]) rotate([0,0,90]) cube([15,2,4],center = true);
	}
}



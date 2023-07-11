use <evolution_ball.scad>
use <evolucean_socket.scad>

$fn = 32;

	rotate([45,0,0]) socket(stem_length = 7);
	rotate([45,0,120]) socket(stem_length = 7);
	rotate([45,0,240]) ball(stem_length = 7);
	rotate([180,0,0]) socket();





use <evolution_ball.scad>

back_diameter = 75;
fudge = 1;
$fn = 32;
hole_short_distance = 49;
hole_long_distance = 58;
sensor_diameter = 9;
hole_array = [[1,1],[-1,1],[1,-1],[-1,-1]];

difference() {
hull() {

	difference() {
		sphere(d=back_diameter,center=true);
		translate([0, 0, -back_diameter/2])  cube(back_diameter, center = true);  //keep just the upper half of the model
	}

	for (i=hole_array) {
		translate([i[0]*hole_short_distance/2, i[1]*hole_long_distance/2-10, 0])
		cylinder(d=12,h=4);
	}

	
}
	for (i=hole_array) {
		translate([i[0]*hole_short_distance/2, i[1]*hole_long_distance/2-10, -1*fudge])
		cylinder(d=2.5,h=50);
    }
	for (i=hole_array) {
		translate([i[0]*hole_short_distance/2, i[1]*hole_long_distance/2-10, 3])
		cylinder(d=9,h=50);
    }
    translate([0,20,14]) rotate([90, 0, 0]) cylinder(d=13,h=100);
    translate([0,-50,-1]) cylinder(d=40,h=100);
}

//difference() {
//	translate([0,20,14]) rotate([90, 0, 0]) cylinder(d=18,h=52);
//	translate([0,20,14]) rotate([90, 0, 0]) cylinder(d=13,h=100);
//}

translate([0,0,35]) ball(stem_length = 3); //ball

for (i = [30,300,330]) {
	rotate([i, 0, 0]) translate([0,0,35]) ball(stem_length = 3);
}

for (i = [60,300]) {
	rotate([330, 0, i]) translate([0,0,35]) ball(stem_length = 3);
}

for (i = [60,300]) {
	rotate([30, 0, i]) translate([0,0,35]) ball(stem_length = 3);
}

for (i = [30,90,120,240,270,330]) {
	rotate([300, 0, i]) translate([0,0,35]) ball(stem_length = 3);
}
//for (i = [150,210]) {
//	rotate([300, 0, i]) translate([0,0,35]) ball(stem_length = 5);
//}

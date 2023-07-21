use <evolution_ball.scad>
holder_diameter = 100;
$fn = 96;

difference() {

	translate([0,0,0]) cylinder(d=holder_diameter,h=15,center = true);
	translate([100,100,22.5]) cube([150,150,50],center=true);
	cylinder(d=4,h=20,center = true);
	translate([0,0,7.5]) cylinder(d=16,h=15,center = true);
    for (i = [24,72,96,360]) {
        rotate([0, 0, i]) translate([0,holder_diameter/2 - 10,4.0]) rotate([320, 0, 0])  cylinder(d=5,h=100,center = true); 
    }
}




    	for (i = [12,36,60,84,108,132,156,180,204,228,252,276,348]) {
    		rotate([0, 0, i]) 
    			translate([0, holder_diameter/2 - 20, 8.5])
					rotate([90, 0, 0]) 
						difference() {
							cube([4,6,12],center = true);
							cube([5,2,4],center = true);
						}
    	}


        	for (i = [24,72,96,360]) {
        	rotate([0, 0, i]) translate([0,holder_diameter/2 - 10,4.0]) rotate([320, 0, 0])  evolucean_link(13,3); //ball
       }

module evolucean_link(a=7,b=0) {
	difference() {
		ball(stem_length=a);
		translate([0,0,a+4])  cube([15,2,4],center = true);
		translate([0,0,a+4]) rotate([0,0,90]) cube([15,2,4],center = true);
		translate([0,0,a+6])  cube([15,4,2],center = true);
		translate([0,0,a+6]) rotate([0,0,90]) cube([15,4,2],center = true);
		translate([0,0,a/2+a/14+b])  cube([15,2,4],center = true);
		translate([0,0,a/2+a/14+b]) rotate([0,0,90]) cube([15,2,4],center = true);
	}
}
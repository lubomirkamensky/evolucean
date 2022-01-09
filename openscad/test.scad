$fn = 128;


    	for (i = [36,144,216,324]) {
    		rotate([0, 0, i]) 
    			translate([0,127/2,0])
    				cover_leg();   				
    		}

module cover_leg() {
	rotate([0,0,270])
	difference() {
		cylinder(d=7,h=53,center=true);
		translate([-30+3.5,0,53/2])
			rotate(a=[-90,0,0])
				linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
					polygon(points=[[0,0],[30,0],[0,10]], paths=[[0,1,2]]);
	}
}
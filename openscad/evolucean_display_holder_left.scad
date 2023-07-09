holder_diameter = 100;
$fn = 128;

difference() {

	translate([0,0,0]) cylinder(d=holder_diameter,h=15,center = true);
	translate([100,100,22.5]) cube([150,150,50],center=true);
	cylinder(d=4,h=20,center = true);
	translate([0,0,7.5]) cylinder(d=16,h=15,center = true);
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


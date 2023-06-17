holder_diameter = 150;
$fn = 128;

difference() {

	translate([0,0,0]) cylinder(d=holder_diameter,h=15,center = true);
	translate([100,100,22.5]) cube([150,150,50],center=true);
	cylinder(d=4,h=20,center = true);
	translate([0,0,7.5]) cylinder(d=16,h=15,center = true);
}


    	for (i = [12,24,36,48,60,72,84,96,108,120,132,144,156,168,180,192,204,216,228,240,252,264,276,288,348,360]) {
    		rotate([0, 0, i]) 
    			translate([0, holder_diameter/2 - 10, 8.5])
					rotate([90, 0, 0]) 
						difference() {
							cube([2,6,8],center = true);
							cube([3,2,4],center = true);
						}
    	}

    	for (i = [12,36,60,84,108,132,156,180,204,228,252,276,348]) {
    		rotate([0, 0, i]) 
    			translate([0, holder_diameter/2 - 30, 8.5])
					rotate([90, 0, 0]) 
						difference() {
							cube([2,6,8],center = true);
							cube([3,2,4],center = true);
						}
    	}

    	for (i = [36,84,132,180,228,276]) {
    		rotate([0, 0, i]) 
    			translate([0, holder_diameter/2 - 50, 8.5])
					rotate([90, 0, 0]) 
						difference() {
							cube([2,6,8],center = true);
							cube([3,2,4],center = true);
						}
    	}
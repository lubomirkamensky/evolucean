use <evolution_ball.scad>



total_height = 19;
total_diameter = 125;
base_thickness = 4;
hole_diameter = 2.5;
hole_short_distance = 49;
hole_long_distance = 58;
sensor_diameter = 9;
fudge = 1;
$fn = 32;
hole_array = [[1,1],[-1,1],[1,-1],[-1,-1]];
correction = 0;
covering_holder_width = 2;
covering_holder_length = 9;

difference() {
	union() {
		difference() {
			//cylinder(d = total_diameter, h = total_height);
			cylinder(r=total_diameter/2+30,h=3);


		}
		cylinder(d=total_diameter,h=3);
		for (i=hole_array) {
			translate([i[0]*hole_short_distance/2, i[1]*hole_long_distance/2-10, 0])
			pillar(hole_diameter,total_height,fudge);
		}
        for (i = [36,144,216,324]) {
    		rotate([0, 0, i]) covering_holder(total_diameter,total_height,base_thickness,covering_holder_width,covering_holder_length);
    	}


    	for (i = [12,24,48,60,72,84,96,108,120,132,156,204,228,240,252,264,276,288,300,312,336,348,360]) {
    		rotate([0, 0, i]) 
    			translate([0, total_diameter/2-4, 4])
					rotate([90, 0, 0]) 
						difference() {
							cube([4,6,12],center = true);
							cube([5,2,4],center = true);
						}
    	}


    	for (i = [12,24,48,60,72,84,96,108,120,132,156,204,228,240,252,264,276,288,300,312,336,348,360]) {
    		rotate([0, 0, i]) 
    			translate([0, total_diameter/2+32.5, 3])
					rotate([90, 0, 0]) 
						difference() {
							cube([6,6,12],center = true);
							cube([8,2,6],center = true);
						}
    	}

        for (i = [18,42,66,90,114,138,162,198,222,270,294,318,342]) {
        	rotate([0, 0, i]) translate([0,83,0]) rotate([320, 0, 0])  ball(stem_length = 18); //ball
       }
        for (i = [30,54,78,102,126,150,210,234,282,306,330]) {
        	rotate([0, 0, i]) translate([0,83,0]) rotate([320, 0, 0])  ball(stem_length = 15); //ball
       }



	}
	for (i=hole_array) {
		translate([i[0]*hole_short_distance/2, i[1]*hole_long_distance/2-10, -1*fudge])
		cylinder(d1 = 4*hole_diameter,d2=2*hole_diameter+fudge, h = base_thickness+2*fudge);
	}


    rotate(90) translate([0, 0, total_height]) 
    	cube([total_diameter,hole_diameter,hole_diameter],center = true);
    
    translate([0, -10, -1*fudge])	
    	cylinder(d = hole_long_distance/2+total_height, h = base_thickness+2*fudge);

    for (i = [78,282]) {
    	rotate([0, 0, i])
    		translate([0, 72, -1*fudge])	
    			cylinder(d = 4, h = base_thickness+2*fudge);
    
    }
    translate([0, -50, 0]) 
    	cube([30,100,40],center = true);

    translate([0, 0, -2]) 
    	cube([200,200,4],center = true);

}



module pillar(hole_diameter,total_height,fudge) {
	difference() {
		rounded_cylinder(r=3*hole_diameter, h=total_height-5, n=1);
		cylinder(d = 2*hole_diameter+fudge, h = (total_height-5)-(2*hole_diameter+fudge/2));
		translate([0, 0, (total_height-5)-(2*hole_diameter+fudge*0.6)]) 
			cylinder(d1= 2*hole_diameter+fudge,d2 = hole_diameter+fudge/2, h = 2*hole_diameter+fudge*0.7);
	}  
}



module covering_holder(total_diameter,total_height,base_thickness,covering_holder_width,covering_holder_length) {
		union() {
		translate([0, (total_diameter+covering_holder_length)/2-fudge, (total_height)/4])
			cube([2*covering_holder_width,covering_holder_length,total_height/2],center = true);
		translate([0, (total_diameter+covering_holder_length)/2-fudge, (total_height)/2])
			rotate([90, 0, 0])
				cylinder(d=3*covering_holder_width,h=covering_holder_length,center = true);
		}
}



module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}


use <evolution_ball.scad>

total_height = 19;
total_diameter = 150;
base_thickness = 4;
hole_diameter = 2.5;
fudge = 1;
$fn = 22;
covering_holder_width = 2;
covering_holder_length = 9;

difference() {
	union() {
		cylinder(d=total_diameter+25,h=base_thickness,center = true);

		for (i = [[-25.4,17.78,-2],[-20.32,-33.02,-2],[7.62,-33.02,-2]]) {
			translate(i) pillar(hole_diameter,total_height,fudge);
		}	

		for (i = [36,144,216,324]) {
    	rotate([0, 0, i]) covering_holder(total_diameter-45,total_height,base_thickness,covering_holder_width,covering_holder_length);
    	}
	}


	for (i = [[-25.4,17.78,0],[-20.32,-33.02,0],[7.62,-33.02,0]]) {
		translate([i[0],i[1],-3]) cylinder(d1 = 4*hole_diameter,d2=2*hole_diameter+fudge, h = base_thickness+2*fudge);	
	}

   cylinder(d=40,h=50,center = true);

    for (i = [-50,50]) {
    	translate([i, 0, -5])	
    			cylinder(d = 4, h = 10);
    
    }



}

    	for (i = [12,24,48,60,120,132,168,192,228,240,300,312,336,348,360]) {
    		rotate([0, 0, i]) 
    			translate([0, total_diameter/2-20, 4])
					rotate([90, 0, 0]) 
						difference() {
							cube([4,6,12],center = true);
							cube([5,2,4],center = true);
						}
    	}

difference() {
	union() {

        	for (i = [72,108,156,180,204,252,288]) {
        	rotate([0, 0, i]) translate([0,58,-1]) rotate([320, 0, 0])  evolucean_link(13,3); //ball
       }
	        for (i = [42,66,90,114,138,162,186,210,234,258,282,306,330]) {
        	rotate([0, 0, i]) translate([0,78,-1]) rotate([320, 0, 0])  evolucean_link(18,2); //ball
       }
        for (i = [30,54,78,102,126,150,174,198,222,246,270,294,318]) {
        	rotate([0, 0, i]) translate([0,78,-1]) rotate([320, 0, 0])  evolucean_link(15,3); //ball
       }
	}
	translate([0, 0, -6.99]) cube([200,200,10],center = true);
}



module pillar(hole_diameter,total_height,fudge) {
	difference() {
		rounded_cylinder(r=3*hole_diameter, h=total_height-5, n=1);
		cylinder(d = 2*hole_diameter+fudge, h = (total_height-5)-(2*hole_diameter+fudge/2));
		translate([0, 0, (total_height-5)-(2*hole_diameter+fudge*0.6)]) 
			cylinder(d1= 2*hole_diameter+fudge,d2 = hole_diameter+fudge/2, h = 2*hole_diameter+fudge*0.7);
	}  
}

module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
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


cover_total_height = 44;
cover_total_diameter = 150;
rate = cover_total_height/(cover_total_diameter*0.3);
cylinder_height = cover_total_height*rate;
fudge = 1;
$fn = 22;
translate([0,0,7.5]) 
intersection() {  //cutting out everithing going over the cover shape perimeter
difference() {  //making the holes through the perimeter and the cover holders
    union() {   //adding the cover holders

    	scale([1,1,1]) 
        difference() { // making the basic cover body
            cover_shape(cylinder_height,cover_total_diameter);
            translate([0,0,-2.6]) 
                cover_shape(cylinder_height-2.5,cover_total_diameter-2.5);
            rotate([90,0,0])  
                scale([1, rate, 1])
                    cylinder(d=(2*cylinder_height)-4,h=cover_total_diameter,center = true);
        }


        for (i = [36,144,216,324]) {
            rotate([0, 0, i]) 
                translate([0,113/2,0])
                    union() {
                        cover_leg(); //holder leg
                        translate([0,7,56.5]) cube([3,20,100],center=true); //holder anchor
                        }               
            }

        for (i = [36,144,216,324]) {
            rotate([0, 0, i]) 
                translate([0,125/2+3,2])
                    rotate([90, 0, 0])
                        difference() {
                                cylinder(d=10,h=25,center=true); //holder grip
                            }
        }

    }
    for (i = [36,144,216,324]) {
        rotate([0, 0, i]) 
            translate([0,118/2,2])
                rotate([90, 0, 0])
                    cylinder(d=6,h=25+fudge,center=true); //hole in holder grip
    }


    translate([-100,50,0]) cube([100,210,44],center=true); //hole for the power and video cables

    translate([100,50,0]) cube([100,210,44],center=true); //hole for the power and video cables





}
cover_shape(cylinder_height,cover_total_diameter);
}


module cover_shape(cylinder_height,cover_total_diameter) {
    difference() {
    intersection() {
    hull() {
        intersection() { //shaping the holes on the head and tale
                rotate([90,0,0])  
                    scale([1, rate, 1])
                        cylinder(d=cover_total_diameter*0.6,h=cover_total_diameter,center = true);
                cylinder(d=cover_total_diameter,h=cover_total_diameter,center = true);
            }
            scale([1, 1, 4/15])
                sphere(d = cover_total_diameter); // the basic body shape
            translate([0,0,0])
                rounded_cylinder(r=cover_total_diameter/4,h=cover_total_height,n=4);  //shaping the top
            rounded_cylinder(r=0.44*cover_total_diameter,h=0.67*cylinder_height,n=4); //shaping the main body
    }
    translate([0, 0, cover_total_diameter/2]) 
        cube(cover_total_diameter, center = true);  //keep just the upper half of the model
    }

}
}

module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}

module cover_leg() {
    rotate([0,0,270])
        cylinder(d=7,h=cover_total_height);
    }

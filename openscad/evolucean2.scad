total_height = 19;
total_diameter = 125;
base_thickness = 4;
hole_diameter = 2.5;
hole_short_distance = 49;
hole_long_distance = 58;
sensor_diameter = 9;
fudge = 1;
$fn = 128;
hole_array = [[1,1],[-1,1],[1,-1],[-1,-1]];
correction = 0;

difference() {
	union() {
		difference() {
			//cylinder(d = total_diameter, h = total_height);
			rounded_cylinder(r=total_diameter/2,h=total_height,n=1);

			translate([0, 0, base_thickness]) 
				cylinder(d = total_diameter-(total_height-base_thickness)
	                   , h = total_height-base_thickness+fudge);
		}
		cylinder(d=total_diameter,h=3);
		for (i=hole_array) {
			translate([i[0]*hole_short_distance/2, i[1]*hole_long_distance/2-10, 0])
			pillar(hole_diameter,total_height,fudge);
		}

	}
	for (i=hole_array) {
		translate([i[0]*hole_short_distance/2, i[1]*hole_long_distance/2-10, -1*fudge])
		cylinder(d1 = 4*hole_diameter,d2=2*hole_diameter+fudge, h = base_thickness+2*fudge);
	}
    for (i = [0:12:360]) {
    	rotate([0, 0, i]) sensor(sensor_diameter,total_height,base_thickness);
    }
    translate([0, 0, total_height]) 
    	cube([total_diameter,hole_diameter,hole_diameter],center = true);

    rotate(90) translate([0, 0, total_height]) 
    	cube([total_diameter,hole_diameter,hole_diameter],center = true);
    
    translate([0, -10, -1*fudge])	
    	cylinder(d = hole_long_distance/2+total_height, h = base_thickness+2*fudge);

    for (i = [[90,0],[180,3*hole_diameter],[270,0],[360,0]]) {
    	rotate([0, 0, i[0]])
    		translate([0, 2*total_height+i[1], -1*fudge])	
    			cylinder(d = 3*hole_diameter, h = base_thickness+2*fudge);
    
    rotate([0,0,90]) translate([0,0,total_height-fudge]) revolve_text((total_diameter-(total_height-base_thickness))/2+fudge, " evolucean.com", 5, 90);
	rotate([0,0,270]) translate([0,0,total_height-fudge]) revolve_text((total_diameter-(total_height-base_thickness))/2+fudge, " lubolab.com", 5, 90);
    }
}	

module pillar(hole_diameter,total_height,fudge) {
	difference() {
		rounded_cylinder(r=3*hole_diameter, h=total_height, n=1);
		cylinder(d = 2*hole_diameter+fudge, h = total_height-(hole_diameter+fudge/2));
		translate([0, 0, total_height-(hole_diameter+fudge*0.6)]) 
			cylinder(d1= 2*hole_diameter+fudge,d2 = hole_diameter+fudge/2, h = hole_diameter+fudge*0.7);
	}  
}

module sensor(sensor_diameter,total_height,base_thickness) {
	translate([0, total_diameter/2+fudge, total_height/2])
		rotate([90, 0, 0]) 
			union() {
			cylinder(d1 = sensor_diameter+fudge/2,d2 = sensor_diameter-fudge/2, h = (total_height-base_thickness)/2+2*fudge);
			fillet_cylinder((sensor_diameter-fudge/2)/2,(total_height-base_thickness)/2+2*fudge,4,3);
		   }
}

module revolve_text(radius, chars, font_size, angle) {
    PI = 3.14159;
    circumference = 2 * PI * radius;
    chars_len = len(chars);
    step_angle = angle / chars_len;
    for(i = [0 : chars_len - 1]) {
        rotate(-i * step_angle) 
            translate([0, radius + font_size / 2, 0]) 
                linear_extrude(2) text(
                    chars[i], 
                    font = "Arial; Style = Bold", 
                    size = font_size, 
                    valign = "center", halign = "center"
                );
    }
}

module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}

module fillet_cylinder(
 r,      // cylinder radius
 h,      // cylinder height
 b=0,    // bottom chamfer radius (=0 none, >0 outside, <0 inside)
 t=0,    // top chamfer radius (=0 none, >0 outside, <0 inside,
 deg=10  // degrees per rib of fillet
)
 rotate_extrude()
  polygon(concat([[0,h],[0,0]],
   [for(a=[0:deg:90]) [r-b*(sin(a)-1), abs(b)*(1-cos(a))]],       //bottom fillet
   [for(a=[90:-deg:0]) [r-t*(sin(a)-1), h-abs(t)*(1-cos(a))]]));  //top fillet
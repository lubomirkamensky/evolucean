use <evolution_ball.scad>

cover_total_height = 44;
cover_total_diameter = 150;
rate = cover_total_height/(cover_total_diameter*0.3);
cylinder_height = cover_total_height*rate;
fudge = 1;
$fn = 96;

intersection() {  //cutting out everithing going over the cover shape perimeter
difference() {  //making the holes through the perimeter and the cover holders
    union() {   //adding the cover holders
        difference() { // making the basic cover body
            cover_shape(cylinder_height,cover_total_diameter);
            translate([0,0,-2.6]) 
                cover_shape(cylinder_height-2.5,cover_total_diameter-2.5);
            difference() {
            rotate([90,0,0])  
                scale([1, rate, 1])
                    cylinder(d=(2*cylinder_height)-4,h=cover_total_diameter,center = true);
            translate([0,0,44]) 
                scale([1, 5/6, 1/3]) 
                    sphere(d=90,center=true);  //hole for camera
            }
        }
        for (i = [36,144,216,324]) {
            rotate([0, 0, i]) 
                translate([0,130/2,0])
                    union() {
                        cover_leg(); //holder leg
                        translate([0,7,56.5]) cube([3,20,100],center=true); //holder anchor
                        }               
            }

        for (i = [36,144,216,324]) {
            rotate([0, 0, i]) 
                translate([0,130/2+3,2])
                    rotate([90, 0, 0])
                        difference() {
                                cylinder(d=10,h=13,center=true); //holder grip
                            }
        }

    }
    for (i = [36,144,216,324]) {
        rotate([0, 0, i]) 
            translate([0,130/2,2])
                rotate([90, 0, 0])
                    cylinder(d=6,h=13+fudge,center=true); //hole in holder grip
    }
    //translate([0,0,-24])
    //cylinder(d=140,h=50,center=true); //cutting the holder grip a bit


    translate([-100,50,0]) cube([104,210,44],center=true); //hole for the power and video cables

    translate([100,50,0]) cube([104,210,44],center=true); //hole for the power and video cables


    translate([0,-25+18,0]) cube([20,2,100],center=true); //hole for camera cable
    translate([-12,24,0]) difference() {  //hole for camera cable
            cylinder(d=64,h=100,center=true);
            cylinder(d=60,h=101,center=true);
    translate([0,10,0]) rotate([0,0,67]) cube([72.3,73,100],center=true);
    }
    rotate([0,0,230]) translate([20,-50,0])  cube([2,43,100],center=true); //hole for camera cable
}
cover_shape(cylinder_height,cover_total_diameter);
}
translate([0,3,31]) ball(); //ball for camera joint

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
translate([0,0,44]) 
    scale([1, 5/6, 1/3]) 
        sphere(d=70,center=true);  //hole for camera
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


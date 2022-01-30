//design is a clone of https://www.thingiverse.com/thing:889439
//I did not want the extra thin areas in the socket and wanted more of a rounded socket edge, hence this project.

//morphology library (for rounding) from https://github.com/openscad/scad-utils
use <../../scad-utils/morphology.scad>

use <dimple.scad>

cover_total_height = 44;
cover_total_diameter = 150;
rate = cover_total_height/(cover_total_diameter*0.3);
cylinder_height = cover_total_height*rate;
fudge = 1;
$fn = 128;

union(){
intersection() {  //cutting out everithing going over the cover shape perimeter
difference() {  //making the holes through the perimeter and the cover holders
    union() {   //adding the cover holders
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
                translate([0,130/2,0])
                    union() {
                        cover_leg(); //holder leg
                        translate([0,7,56.5]) cube([3,20,100],center=true); //holder anchor
                        }               
            }

        for (i = [36,144,216,324]) {
            rotate([0, 0, i]) 
                translate([0,130/2,2])
                    rotate([90, 0, 0])
                        difference() {
                                cylinder(d=10,h=7,center=true); //holder grip
                            }
        }


    }
    for (i = [36,144,216,324]) {
        rotate([0, 0, i]) 
            translate([0,130/2,2])
                rotate([90, 0, 0])
                    cylinder(d=6,h=7+fudge,center=true); //hole in holder grip
    }
    translate([0,0,-24])
    cylinder(d=140,h=50,center=true); //cutting the holder grip a bit

    for (i = [48,60,72,84,96,108,120,132,228,240,252,264,276,288,300,312]) {
        rotate([0, 0, i]) 
            translate([0,130/2,2])
                rotate([90, 0, 0])
                    cylinder(d=10,h=50,center=true); //holes through the perimeter
    }
    translate([-100,50,0]) cube([100,95,44],center=true); //hole for the power and video cables
    //translate([0,60,0]) cube([20,2,100],center=true); //hole for camera cable
}
cover_shape(cylinder_height,cover_total_diameter);
}
translate([0,-60,43]) ball();
}

module cover_shape(cylinder_height,cover_total_diameter) {
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
            translate([0,50,0])
                rounded_cylinder(r=cover_total_diameter/7,h=cover_total_height,n=4);  //shaping the top
            rounded_cylinder(r=0.44*cover_total_diameter,h=0.67*cylinder_height,n=4); //shaping the main body
    }
    translate([0, 0, cover_total_diameter/2]) 
        cube(cover_total_diameter, center = true);  //keep just the upper half of the model
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


module socket_wall(diameter, wall_thickness, opening_angle) {
    r = diameter / 2;
    //radius for rounding is just under half of wall thickness because the rounding module can over-optimize when walls are less than 2*r
    rounding(r=wall_thickness * 0.499) difference() {
        circle(r=r);
        circle(r=r - wall_thickness);
        //this only works for opening_angle < 180, but if your socket is only half a socket, you're not going to be holding the ball for very long.
        rotate(90 - opening_angle / 2) square(r);
    }
}

module ball_wall(diameter, wall_thickness, base_cutoff_percent) {
    r = diameter / 2;
    cutoff_movement = r - diameter * base_cutoff_percent;
    difference() {
        circle(r=r);
        circle(r=r - wall_thickness);
        translate([0, cutoff_movement]) square(r);
    }
}

module connector_wall(ball_diameter, tunnel_diameter, wall_thickness, stem_length) {
    br = ball_diameter / 2;
    tr = tunnel_diameter / 2;
    difference() {
        translate([tr, -br-stem_length]) square([wall_thickness, br + stem_length]);
        circle(r=br - wall_thickness * 0.5);
    }
}

module flex_cut(ball_diameter, flex_depth_percent, flex_cut_percent) {
    br = ball_diameter / 2;
    depth = br - ball_diameter * flex_depth_percent;
    cut_width = br * flex_cut_percent;
    translate([0, 0, depth]) union() {
        rotate([0, 90, 0]) translate([0, 0, -br]) cylinder(r=cut_width, h=ball_diameter);
        translate([-br, -cut_width / 2, 0]) cube([ball_diameter, cut_width, ball_diameter]);
    }
}

module dimple_cut(ball_diameter, wall_thickness, dimple_radius, dimple_depth, flex_depth_percent, flex_cut_percent) {
    br = ball_diameter / 2;
    depth = br - ball_diameter * flex_depth_percent;
    cut_width = br * flex_cut_percent / 1.5;
    rotate([90, 0, 45]) linear_extrude(height=ball_diameter) rounding(0.499 * cut_width) difference() {
        shell(cut_width) {
            circle(r = dimple_radius);
            translate([-dimple_radius, depth]) square([2 * dimple_radius, -depth]);
        }
        translate([-dimple_radius, depth * 2]) square([2 * dimple_radius, -depth * 2]);
    }
}

module ball(
    ball_diameter = 16,
    wall_thickness = 1.8,
    base_cutoff_percent = 0.2,  //percentage of diameter to cut off the end of the ball, values >= 0.5 are invalid
    stem_length = 0,
    tunnel_diameter = 5,
    small_ball_multiplier = 1.02,  //increase or decrease ball to snug (greater than 1.0) or loosen (less than 1.0) fit
    rounded_opening = true,  //round the edges of the opening in the ball, lowers surface area, but increases diameter of cables that can fit through a bent joint
    dimples = true,
    dimple_radius = 1.0,
    dimple_depth = 0.5
) {
    small_ball_diameter = (ball_diameter - wall_thickness * 2) * small_ball_multiplier;
    translate([0, 0, small_ball_diameter / 2 + stem_length]) difference() {
        rotate_extrude() {
            fillet(r=wall_thickness*0.499) difference() {
                union() {
                    if (rounded_opening) {
                        //lower resolution to 15%, save $fn for use in the wall
                        fn = $fn;
                        rounding(r=wall_thickness * 0.15, $fn=ceil(fn * 0.15)) ball_wall(small_ball_diameter, wall_thickness, base_cutoff_percent, $fn=fn);
                    } else {
                        ball_wall(small_ball_diameter, wall_thickness, base_cutoff_percent);
                    }
                    connector_wall(small_ball_diameter, tunnel_diameter, wall_thickness, stem_length);
                }
                translate([-small_ball_diameter + tunnel_diameter / 2, -(small_ball_diameter * 0.5 + stem_length)]) square([small_ball_diameter, small_ball_diameter + stem_length]);
            }
        }
        if (dimples) {
            // TODO - make this less magic, don't want to see any arbitrary numbers in here
            spiral_dimples(small_ball_diameter / 2, dimple_radius=dimple_radius, dimple_depth=dimple_depth, phi=-26, phi_min=-45, phi_max=30);
        }
    }
}

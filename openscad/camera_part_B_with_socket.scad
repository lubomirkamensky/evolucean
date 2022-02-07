//design is a clone of https://www.thingiverse.com/thing:889439
//I did not want the extra thin areas in the socket and wanted more of a rounded socket edge, hence this project.

//morphology library (for rounding) from https://github.com/openscad/scad-utils
use <../../scad-utils/morphology.scad>

use <dimple.scad>

fudge = 1;
$fn = 128;

rotate([270,0,0])
difference() {
union() {
    difference() {
        scale([1, 4/5, 1/3])
            sphere(d=53,center=true); 
        union() {
        translate([0,-2.5+fudge/2,2])
            cube([25.4,23+fudge,2.4],center=true);  
        translate([0,-2.5+fudge/2,0])
            cube([25,20,10],center=true);   

        }
        translate([0,0.3,8])
            cube([9,9.3,16],center=true);    
        translate([0,12,-8])
            cube([20,5,26],center=true);    
    }   
    translate([25/2-0.3,-2,3+fudge/2])
        cube([1,23+fudge,1],center=true);   
    translate([-25/2+0.3,-2,3+fudge/2])
        cube([1,23+fudge,1],center=true);   

    translate([25/2-0.3,-2,0.8+fudge/2])
        cube([1,23+fudge,1],center=true);   
    translate([-25/2+0.3,-2,0.8+fudge/2])
        cube([1,23+fudge,1],center=true);   
rotate([180,0,0]) translate([0,3,7]) socket();
}
translate([0,32,0])
    cube([55,55,55],center=true);   
}




//ball();

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

module socket(
    ball_diameter = 16,
    wall_thickness = 1.8,
    opening_angle = 120,  //socket opening total angle
    stem_length = 0,
    tunnel_diameter = 5,
    flex_depth_percent = 0.7,  //depth of flex cut as percentage of diameter
    flex_cut_percent = 0.22,  //round cut radius, flat cut width as percentage of diameter
    dimples = false,
    dimple_radius = 1.0,
    dimple_depth = 0.5
) {
    translate([0, 0, ball_diameter / 2 + stem_length]) difference() {
        union() {
            rotate_extrude() {
                fillet(r=wall_thickness*0.499) difference() {
                    union() {
                        socket_wall(ball_diameter, wall_thickness, opening_angle);
                        connector_wall(ball_diameter, tunnel_diameter, wall_thickness, stem_length);
                    }
                    translate([-ball_diameter + tunnel_diameter / 2, -(ball_diameter * 0.5 + stem_length)]) square([ball_diameter, ball_diameter + stem_length]);
                }
            }
            if (dimples) {
                rotate([0, 0, -45]) intersection() {
                    sphere(r=ball_diameter / 2 - wall_thickness / 2);
                    dimple(ball_diameter / 2 - wall_thickness, dimple_radius, dimple_depth);
                }
            }
        }
        flex_cut(ball_diameter, flex_depth_percent, flex_cut_percent);
        rotate([0, 0, 90]) flex_cut(ball_diameter, flex_depth_percent, flex_cut_percent);
        if (dimples) {
            dimple_cut(ball_diameter, wall_thickness, dimple_radius, dimple_depth, flex_depth_percent, flex_cut_percent);
        }
    }
}




//design is a clone of https://www.thingiverse.com/thing:889439
//I did not want the extra thin areas in the socket and wanted more of a rounded socket edge, hence this project.

//morphology library (for rounding) from https://github.com/openscad/scad-utils
use <scad-utils/morphology.scad>

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



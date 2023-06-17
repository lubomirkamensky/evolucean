use <mcad/gears.scad>
translate([0,0,0]) linear_extrude(height = 20, center = true, convexity = 10, twist = 0)
	 gear(number_of_teeth=18,diametral_pitch=1);
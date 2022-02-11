fudge = 1;
$fn = 128;
rotate([90,0,0])
difference() {
union() {
	difference() {
		scale([1, 4/5, 1/3])
			sphere(d=53,center=true); 
		union() {
		translate([0,-2.5+fudge/2,2])
			cube([25,23+fudge,5],center=true);	
		translate([0,-2.5+fudge/2,0])
			cube([25,20,10],center=true);	
		}
		translate([0,0,8])
			cube([9,9,16],center=true);	
		translate([0,8,-8])
			cube([20,12,26],center=true);	
	}	
	translate([25/2-fudge/2,-2,3+fudge/2])
		cube([1,23+fudge,1],center=true);	
	translate([-25/2+fudge/2,-2,3+fudge/2])
		cube([1,23+fudge,1],center=true);	

	translate([25/2-fudge/2,-2,0.9+fudge/2])
		cube([1,23+fudge,1],center=true);	
	translate([-25/2+fudge/2,-2,0.9+fudge/2])
		cube([1,23+fudge,1],center=true);	
}
translate([0,-23,0])
	cube([55,55,55],center=true);	
}


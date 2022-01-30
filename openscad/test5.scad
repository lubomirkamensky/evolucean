fudge = 1;
$fn = 128;

difference() {
	scale([1, 4/5, 1])
		cylinder(d=45,h=8, center=true); 
	translate([0,-2.5+fudge/2,2])
		cube([25,23+fudge,4+fudge],center=true);
	translate([0,45/2+9,0])
		cube([45,45,45],center=true);		
}

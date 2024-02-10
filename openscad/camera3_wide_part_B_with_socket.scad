use <evolucean_socket.scad>

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
            cube([11.6,14.9,16],center=true);    
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




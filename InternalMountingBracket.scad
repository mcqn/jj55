// Mounting bracket for use inside a jam-jar
// https://github.com/mcqn/jj55

// Uses the arc generating OpenSCAD library from https://www.thingiverse.com/thing:1092611/
use <arc.scad>


// Variables
//

// Change these to suit the jar you're using
neck_diameter = 47;
jar_outside_diameter = 70;

// Diameter of the mounting holes to cut out of the mounting plate
mounting_hole_diameter = 3;
// Distance between the centres of the mounting holes
mounting_hole_separation = 30;



// Constants
// You shouldn't need to change these
//

// Length of the flexible arms (in degrees)
flex_angle = 120;
// Thickness of the arms
assembly_thickness = 2.1;
// Width of each mount
assembly_width = 8;


difference() {
    union() {
        // Mounting plate
        translate([-assembly_thickness/2, -neck_diameter/2, 0]) 
            cube([assembly_thickness, neck_diameter, assembly_width]);

        // Flexible arms
        flex_arm();
        rotate([0,0,180]) flex_arm();
    };

    // Mounting holes
    translate([-assembly_thickness, mounting_hole_separation/2, assembly_width/2]) 
        rotate([0,90,0]) 
        cylinder(d=mounting_hole_diameter, h=2*assembly_thickness, $fn=30);
    translate([-assembly_thickness, -mounting_hole_separation/2, assembly_width/2]) 
        rotate([0,90,0]) 
        cylinder(d=mounting_hole_diameter, h=2*assembly_thickness, $fn=30);
}

module flex_arm()
{
    translate([0, (neck_diameter-jar_outside_diameter)/2-assembly_thickness, 0])
        // Have it 
        rotate([0, 0, (180-flex_angle)/2]) 
        // Make it 3D
        linear_extrude(assembly_width) 
        // Create 2D arc
        arc(jar_outside_diameter/2, assembly_thickness, flex_angle);   
}

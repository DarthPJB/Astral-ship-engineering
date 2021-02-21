// Laser Measure Mounting
// John Bargman 2020-11-19

// All measurements in millimeters

// Uses section
use<library.scad>

// Module defintion
module Default_Module()
{
    origin = [0,0,0];
    origin_rotation = [0,90,90];

    translate(origin)
    {
        rotate(origin_rotation)
        {
            //Use a union, hull, or some module call and assemble here
            cylinder(100,10,10, center = true);   
        }
    }
}

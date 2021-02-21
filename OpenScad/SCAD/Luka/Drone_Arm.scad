// Arms of LukaDrone
// Module used by LukaDrone

//Call this to Make a Drone Arm
module Drone_Arm()
{
    union()
    {
        hull()
        {
            difference()
            {
                sphere(8, $fn=50);
                translate([0,0,10]) cube(20, center=true);
            }
            translate([20,0,-8])   
                sphere(4);
        }
        hull()
        {
            translate([20,0,-8])   
                sphere(4);
            translate([40,0,-6])
                sphere(4,$fn=100);
        }
    }
}

Drone_Arm();
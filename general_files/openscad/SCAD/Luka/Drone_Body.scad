use<Drone_Arm.scad>

module Drone_Body()
{
    translate([0,0,0])
    {
        union()
        {
             difference()
             {
                hull()
                {
                    sphere(15,$fn=100);
                    translate([0,9,0])
                        sphere(13,$fn=100);
                }
                translate([0,-10,0])
                    sphere(11,$fn=100);
                translate([-10,-10,-33])
                    cube(20);
            }
        }
    }
}

Drone_Body();
translate([0,10,0])
rotate([0,0,45])
for(count = [0:3])
{
    rotate([0,0,count*90])
        translate([-50,0,0])
            color("red")
                Drone_Arm();
}
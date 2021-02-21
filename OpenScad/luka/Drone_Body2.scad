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

//DRAW DRONE BODY
Drone_Body();
num_arms = 4;
//Move to the right place
translate([0,10,0])
rotate([0,0,(360/num_arms)/2])

//Loop to make FOUR arms

for(count = [0:num_arms-1]) // 0 - 1 - 2 - 3
{
    //Rotate 
    rotate([0,0,count*(360/num_arms)])
        //Then Move
        translate([-50,0,0])
            //Set Colour
            color("red")
                //draw Arms
                Drone_Arm();
}
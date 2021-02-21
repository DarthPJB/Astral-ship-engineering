// Mounting bracket for second Axis Gimble
// John Bargman 2020-11-19

// All measurements in millimeters

// Uses Laser-level & Laser Measure Mount
use <Laser Level.scad>

//Set to height detail only for rendering:
$fn= $preview == true? 20 : 30;

Laser_Gimble_TopWall_Width = 2;

Tolerance = 0.1;
Mounting_Screw_Diamiter = 8 + Tolerance;
Mounting_Screw_Distance = 20;
Laser_Gimble_Height = 30;
Laser_Gimble_Width_Top = 100;
Laser_Gimble_Guide_Height = Laser_Gimble_Height / 3;
Laser_Gimble_Width_Bottom = 80;
Laser_Gimble_Cull_Width = 85;

minkowskiRound = 1;

module Laser_Level_Gimble_Base()
{
    origin = [0,0,-(Laser_Gimble_Height + Laser_Gimble_TopWall_Width + minkowskiRound)];

        difference()
        {
            translate(origin)
            minkowski()
            {
                difference()
                {
                    // The Main peice is a conical cylinder
                    cylinder(h= Laser_Gimble_Height + Laser_Gimble_TopWall_Width, 
                        d1=Laser_Gimble_Width_Bottom, 
                        d2=Laser_Gimble_Width_Top);
                    // A ring-shaped mask is used to cull the outside of the mount.
                    difference()
                    {   
                        translate([0,0, -(Laser_Gimble_Height - 10)])
                            cylinder(h=Laser_Gimble_Height * 2, 
                            d = Laser_Gimble_Width_Top + 10);

                        translate([0,0,-(Laser_Gimble_Height - 10) + Tolerance])
                            cylinder(h=Laser_Gimble_Height *2 + (Tolerance *2),
                            d = Laser_Gimble_Cull_Width);
                    }
                }
                //Sphere is used for minkowski - to apply rounding
                sphere(minkowskiRound);
            }
            //Add laser-level to difference - removing it from above 
            translate([0,0,-Laser_Gimble_TopWall_Width])
                LaserLevel();

            //Also remove mounting holes
            translate(origin)
            union()
            {

                translate([Mounting_Screw_Distance,Mounting_Screw_Distance,-Tolerance])
                    cylinder(Laser_Gimble_Height*2, d= Mounting_Screw_Diamiter + Tolerance);
                translate([Mounting_Screw_Distance,-Mounting_Screw_Distance,-Tolerance])
                    cylinder(Laser_Gimble_Height*2, d= Mounting_Screw_Diamiter+ Tolerance);
                translate([-Mounting_Screw_Distance,0,-Tolerance])
                    cylinder(Laser_Gimble_Height*2, d= Mounting_Screw_Diamiter+ Tolerance);
            }
        }
}

module Laser_Level_Gimble_Top()
{
        origin = [0,0,Tolerance];

        union()
        {
            translate(origin)
                cylinder(h=Laser_Gimble_Guide_Height, d = Laser_Gimble_Cull_Width /1);

            translate(origin - [0,0,Laser_Gimble_TopWall_Width])
            union()
            {
            //Also Add mounting holes
                translate([Mounting_Screw_Distance,Mounting_Screw_Distance,-Tolerance])
                    cylinder(Laser_Gimble_Guide_Height, d= Mounting_Screw_Diamiter - Tolerance);
                translate([Mounting_Screw_Distance,-Mounting_Screw_Distance,-Tolerance])
                    cylinder(Laser_Gimble_Guide_Height, d= Mounting_Screw_Diamiter - Tolerance);
                translate([-Mounting_Screw_Distance,0,-Tolerance])
                    cylinder(Laser_Gimble_Guide_Height, d= Mounting_Screw_Diamiter - Tolerance);
            }
        }

}

//if not a preview, render with rounding for final-print
if($preview == false)
{
    Laser_Level_Gimble_Base();
}
else
{
    //if a preview render, do not round-anything, and also show other parts
    Laser_Level_Gimble_Base();
}
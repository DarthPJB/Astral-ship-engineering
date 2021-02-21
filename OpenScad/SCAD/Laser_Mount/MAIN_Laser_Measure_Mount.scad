// Laser Measure Mounting
// John Bargman 2020-11-19

// All measurements in millimeters

// Uses Laser_measure
use<Laser Measure.scad>

//Set to height detail only for rendering:
$fn= $preview == true? 20 : 30;
minkowskiRound = 1;

Tolerance = 0.2;
origin = [0,0,1 + Tolerance];


Measure_Holder_Length = 90;
Measure_Holder_Wall_Width = 3;
Measure_Holder_Floor_Width = 3;

Measure_Pointer_Length = 120;

Measure_Width=52 + Tolerance  *2;
Measure_Depth=115.5+ Tolerance  *2;
Measure_Height=29+ Tolerance  *2;

Gimble_Arm_Cuff_Diameter = 18;
Gimble_Cuff_Center_Depth = 30;

Laser_Gimble_Cull_Width = 85;
Gimble_Arm_Retraction = 5 + (minkowskiRound * 2);

module Laser_Measure_Keyhole_CutOut(grow = true)
{
    change = grow ? Tolerance : 0 -Tolerance;
    translate(origin)
        rotate([90,0,90])
            cylinder(d=(Gimble_Arm_Cuff_Diameter / 3 ) + change , h=Laser_Gimble_Cull_Width, center=true);
    translate(origin)
    cube([Laser_Gimble_Cull_Width, (Gimble_Arm_Cuff_Diameter / 4) + change, (Gimble_Arm_Cuff_Diameter / 1.5) + change], center = true);
}

module Laser_Measure_Keyhole()
{
    difference()
    {
        Laser_Measure_Keyhole_CutOut(false);
    translate([-Gimble_Cuff_Center_Depth,-Laser_Gimble_Cull_Width/2,-Laser_Gimble_Cull_Width/2])
        cube([Laser_Gimble_Cull_Width,Laser_Gimble_Cull_Width,Laser_Gimble_Cull_Width]);
    }
}

module Laser_Measure_Pointer()
{
    color("#ff3355")
    {
        Laser_Measure_Keyhole();
        translate(origin + [(-Laser_Gimble_Cull_Width/2) + Tolerance,0,0])
        difference()
        {
            hull()
            {
                sphere(d=(Gimble_Arm_Cuff_Diameter/1.5) + Tolerance * 2);
                translate([0,Measure_Pointer_Length,0])
                    rotate([0,-90,0])
                    cylinder(h=Gimble_Arm_Cuff_Diameter/1.5,d=0.1,$fn=2);
            }
            translate([0,-Laser_Gimble_Cull_Width/2,-Gimble_Arm_Cuff_Diameter/2])
                cube([Gimble_Arm_Cuff_Diameter,Laser_Gimble_Cull_Width * 2,Gimble_Arm_Cuff_Diameter]);
            translate([-(Gimble_Arm_Cuff_Diameter+Measure_Holder_Wall_Width),-Laser_Gimble_Cull_Width/2,-Gimble_Arm_Cuff_Diameter/2])
                cube([Gimble_Arm_Cuff_Diameter,Laser_Gimble_Cull_Width * 2,Gimble_Arm_Cuff_Diameter]);
        }
    }
}


module Laser_Measure_Mount()
{
    Measure_Mount_Width = (Measure_Width - minkowskiRound*2 ) + Measure_Holder_Wall_Width * 2;

    color("#bbcc55")
    difference()    
    {   
        union()
        {
            minkowski()
            {
                translate([0,0,-Measure_Holder_Floor_Width] + origin)
                    cube(   [Measure_Mount_Width, 
                        Measure_Holder_Length,
                        Measure_Height ]        , center = true);
                sphere(minkowskiRound);
            }
            minkowski()
            {
                translate(origin)
                    rotate([90,0,90])
                        cylinder(d=Gimble_Arm_Cuff_Diameter -((minkowskiRound * 2) + Tolerance), h=(Laser_Gimble_Cull_Width - Gimble_Arm_Retraction) + Tolerance * 2, center=true);
                sphere(minkowskiRound);
            }
            
            
        }
        Laser_Measure_Keyhole_CutOut();

        translate(origin+[0,-14,0])
            #Laser_Measure();
    }
}

!Laser_Measure_Mount();
Laser_Measure_Pointer();
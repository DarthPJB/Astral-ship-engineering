use<MAIN_Gimble_Split.scad>
use<MAIN_Laser_Measure_Mount.scad>
use<MAIN_Laser_Mount.scad>

Gimble_Arm_Height = 85;
//if a preview render, do not round-anything, and also show other parts
Laser_Level_Gimble_Base();
Gimble_Base_Split_V1();
Gimble_Base_Split_V2();
Gimble_Angle_Guide();
//Use a union, hull, or some module call and assemble here
translate([0,0, Gimble_Arm_Height])
    rotate([0,0,90])
    {
        Laser_Measure_Mount();
        Laser_Measure_Pointer();
    }
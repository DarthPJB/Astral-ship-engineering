// recreation of the Laser_Level head-unit from the workshop
// John Bargman 2020-11-19

//all measurements in millimeters

// Top of the laser level
module LaserLevel()
{
    //Add this tolerance to all measurements (to slip-fit)
    Tolerance = 0.5;
    //Set to height detail only for rendering:
    $fn= $preview == true? 50 : 100;


    //measurements for the cylender section at the top of the cone.
    Circle_Diameter = 67;
    Circle_Diameter_BatteryBox_Top = 67.5;
    Circle_Radius= Circle_Diameter /2 ;

    //measurements for the battery box
    BatteryBox_Width = 47 
        + (Tolerance *2);
    BatteryBox_Height=62
        + (Tolerance *2);

    BatteryBox_Bottom_Depth=7.5;
    BatteryBox_Top_Middle_Depth=6;

    Window_Height = 35;
    Window_Width = 25;
    Window_Depth = 10;

    //lower cone diameter
    Cone_Top_Circle_Diameter = 74;
    Cone_Middle_Circle_Diameter = 79;
    Cone_Bottom_Circle_Diameter = 78;

    Circle_Height = 12;
    BatteryBox_Top_Height=15;
    Level_UpperMiddle_distance = 30;
    Level_window_distance = 35;
    Level_Middle_Distance = 55;
    LaserLevel_Total_Height = 100;

    origin = [0,0,0];

    translate(origin)
    union()
    {
        //Effectively the height of the rounded cylinder atop the measure
        Circle_Dist = Circle_Height + Tolerance;
        //Gimble Diameters at different points
        Gimble_Base_Top = Circle_Diameter + (Tolerance * 2);
        Gimble_Base_BatteryBox_Top= Circle_Diameter_BatteryBox_Top +(Tolerance * 2);
        Gimble_Base_UpperMiddle = Cone_Top_Circle_Diameter + (Tolerance * 2);
        Gimble_Base_Middle = Cone_Middle_Circle_Diameter  +(Tolerance * 2);
        Gimble_Base_Bottom = Cone_Bottom_Circle_Diameter +(Tolerance * 2);
 
        BatteryBox_Distance = (Circle_Radius + (BatteryBox_Top_Middle_Depth + Tolerance));


        //Battery Box is a rounded cube, translated into position.
        translate([-BatteryBox_Distance,-BatteryBox_Width/2, -(BatteryBox_Height + BatteryBox_Top_Height)])
            minkowski()
            {
                cube([BatteryBox_Distance,
                    BatteryBox_Width,
                    BatteryBox_Height]);
                sphere(1);
            }
        
        difference()
        {

            union()
            {
                //Top Circular fitting is modeled as a rounded cylender
                translate([0,0,-Circle_Dist])
                    minkowski()
                    {
                        cylinder(h = Circle_Dist,
                            d1 = Gimble_Base_Top -2,
                            d2 = Gimble_Base_Top -2);
                        difference()
                        {
                            sphere(1,$fn = 5);
                            translate([0,0,-1])
                            cylinder(h = 1,
                                d1 = 2,
                                d2 = 2);
                        }
                    }

                hull()
                {
                //Conical top secion modeled as a series of cones
                    First_Cone_Base = BatteryBox_Top_Height;
                    First_Cone_Height = BatteryBox_Top_Height - Circle_Dist;
                    Second_Cone_Base = Level_UpperMiddle_distance;
                    Second_Cone_Height = Level_UpperMiddle_distance - First_Cone_Base;
                    Third_Cone_Base = Level_Middle_Distance;
                    Third_Cone_Height = Level_Middle_Distance - Second_Cone_Base;

                    translate([0,0,-First_Cone_Base])
                        cylinder(h = First_Cone_Height + Tolerance, 
                            d1 = Gimble_Base_BatteryBox_Top, 
                            d2 = Gimble_Base_Top);
                    translate([0,0, -Second_Cone_Base])
                        cylinder(h = Second_Cone_Height + Tolerance,
                        d1 = Gimble_Base_UpperMiddle,
                        d2 = Gimble_Base_BatteryBox_Top);
                    translate([0,0, -Third_Cone_Base])
                        cylinder(h = Third_Cone_Height + Tolerance,
                        d1 = Gimble_Base_Middle,
                        d2 = Gimble_Base_UpperMiddle);
                    translate([0,0,-LaserLevel_Total_Height])
                            cylinder(
                                h = (LaserLevel_Total_Height - Third_Cone_Base) + Tolerance, 
                                d1 = Gimble_Base_Bottom, 
                                d2 = Gimble_Base_Middle);
                }
            }

            //This cube is removed to make the hollow of the laser-window (for reference)
            translate([Circle_Radius - Window_Depth, -Window_Width / 2, -(Level_window_distance + Window_Height)])
                cube([Circle_Radius, Window_Width, Window_Height]);
        } 
    }
    
}

LaserLevel();
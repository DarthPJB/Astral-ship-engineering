// Laser Measure Mounting
// John Bargman 2020-11-19

// All measurements in millimeters

// Uses section
use <MAIN_Laser_Mount.scad>
use <MAIN_Laser_Measure_Mount.scad>


//Set to height detail only for rendering:
$fn= $preview == true? 20 : 30;


Tolerance = 0.2;
Laser_Gimble_Width_Top = 100;
Laser_Gimble_Cull_Width = 85;


Rounding_Hull_Sphere_Seperation = 20;
Rounding_Hull_Sphere_Diameter = 40;
Rounding_Hull_Sphere_Height = Rounding_Hull_Sphere_Diameter + 20;

Gimble_Arm_Height = 85;

Gimble_Cuff_Squeeze = 2;
minkowskiRound=1;

origin = [0,0,minkowskiRound + Tolerance];
origin_rotation = [0,0,0];

Gimble_Arm_Cuff_Diameter = 18;
Gimble_Cuff_Center_Depth = 30;
Gimble_Arm_Retraction = 5 + (minkowskiRound * 2);

// Module defintion
module Gimble_Split_Base()
{
    translate(origin)
    {
        rotate(origin_rotation)
        {

                difference()
                {
                    minkowski()
                    {
                        cylinder(h=Gimble_Arm_Height-minkowskiRound  *2,d=Laser_Gimble_Cull_Width - ((minkowskiRound + Tolerance) * 2) );
                        sphere(minkowskiRound);
                    }
                    union()
                    {
                        HullSphere1 = [Rounding_Hull_Sphere_Seperation,0,Rounding_Hull_Sphere_Height];
                        HullSphere2 = [-Rounding_Hull_Sphere_Seperation,0,Rounding_Hull_Sphere_Height];
                        HullSphere3 = [Rounding_Hull_Sphere_Seperation,0,Rounding_Hull_Sphere_Height*2];
                        HullSphere4 = [-Rounding_Hull_Sphere_Seperation,0,Rounding_Hull_Sphere_Height*2];
                        HullSphere5 = [Rounding_Hull_Sphere_Seperation,0,Rounding_Hull_Sphere_Height - 20];
                        HullSphere6 = [-Rounding_Hull_Sphere_Seperation,0,Rounding_Hull_Sphere_Height - 20];

                        HullSphere7 = [Laser_Gimble_Cull_Width/2,     Laser_Gimble_Cull_Width/2, Gimble_Arm_Height /1.7];
                        HullSphere8 = [-Laser_Gimble_Cull_Width/2,    Laser_Gimble_Cull_Width/2, Gimble_Arm_Height /1.7];
                        HullSphere9 = [Laser_Gimble_Cull_Width/2,     -Laser_Gimble_Cull_Width/2, Gimble_Arm_Height/1.7];
                        HullSphere10 = [-Laser_Gimble_Cull_Width/2,   -Laser_Gimble_Cull_Width/2, Gimble_Arm_Height /1.7];

                        translate(HullSphere1)
                            sphere(Rounding_Hull_Sphere_Diameter);
                        translate(HullSphere2)
                            sphere(Rounding_Hull_Sphere_Diameter);
                        translate(HullSphere3)
                            sphere(Rounding_Hull_Sphere_Diameter);
                        translate(HullSphere4)
                            sphere(Rounding_Hull_Sphere_Diameter);
                        translate(HullSphere5)
                            sphere(Rounding_Hull_Sphere_Diameter);
                        translate(HullSphere6)
                            sphere(Rounding_Hull_Sphere_Diameter);


                        translate(HullSphere7)
                            sphere(Rounding_Hull_Sphere_Diameter/1.2);
                        translate(HullSphere8)
                            sphere(Rounding_Hull_Sphere_Diameter/1.2);
                        translate(HullSphere9)
                            sphere(Rounding_Hull_Sphere_Diameter/1.2);
                        translate(HullSphere10)
                            sphere(Rounding_Hull_Sphere_Diameter/1.2);
                    }
                }
        }
    }
}

module Gimble_Base_Split_Final()
{
    union()
    {
        difference()
        {
            union()
            {
                translate(origin + [0,0,Gimble_Arm_Height])
                    rotate([90,0,0])
                        cylinder(d=(Gimble_Arm_Cuff_Diameter + Tolerance) * 2, h= Laser_Gimble_Cull_Width - Gimble_Arm_Retraction, center=true);
                Gimble_Split_Base();
                translate(-origin)
                Laser_Level_Gimble_Top();
            }
            union()
            {
                //Use two cubes to carve the outside
                translate(origin + [-Laser_Gimble_Cull_Width/2 - Gimble_Arm_Cuff_Diameter + Gimble_Cuff_Squeeze,-Laser_Gimble_Cull_Width/2 , Gimble_Arm_Height /2])
                    cube([Laser_Gimble_Cull_Width/2+ Tolerance, Laser_Gimble_Cull_Width, Gimble_Arm_Height]);
                translate(origin + [Gimble_Arm_Cuff_Diameter - Gimble_Cuff_Squeeze,-(Laser_Gimble_Cull_Width/2), Gimble_Arm_Height /2])
                    cube([Laser_Gimble_Cull_Width/2, Laser_Gimble_Cull_Width, Gimble_Arm_Height]);

                //Use two cubes to remove the outside-edge (to make a printable flat area)
                translate([-Laser_Gimble_Cull_Width/2,(Laser_Gimble_Cull_Width/2)- Gimble_Arm_Retraction/2 - Tolerance,-10])
                    cube([Laser_Gimble_Cull_Width,Laser_Gimble_Cull_Width/2, Gimble_Arm_Height * 2]);
                translate([-Laser_Gimble_Cull_Width/2,-Laser_Gimble_Cull_Width,-10])
                    cube([Laser_Gimble_Cull_Width,Laser_Gimble_Cull_Width/2 + Gimble_Arm_Retraction/2 + Tolerance, Gimble_Arm_Height * 2]);

                //and two cylinders to carve the inside
                translate(origin + [0,0,Gimble_Arm_Height])
                    rotate([90,0,0])
                        cylinder(d=Gimble_Arm_Cuff_Diameter * 2.1, h= Gimble_Cuff_Center_Depth * 2 + Tolerance, center=true);
                translate(origin + [0,0,Gimble_Arm_Height])
                    rotate([90,0,0])
                       cylinder(d=Gimble_Arm_Cuff_Diameter+ Tolerance, h=(Laser_Gimble_Cull_Width - Gimble_Arm_Retraction) + Tolerance * 2, center=true);
            }
        }
    }

}


module Gimble_Base_Split_V1()
{
    color("#550033")
    {
        difference()
        {
            Gimble_Base_Split_Final();
            translate([-Laser_Gimble_Cull_Width/2,-Tolerance,-10])
                cube([Laser_Gimble_Cull_Width,Laser_Gimble_Cull_Width/2, Gimble_Arm_Height * 2]);
        }
    }
}

module Gimble_Base_Split_V2()
{
    color("#33cc55")
    {
        difference()
        {
            Gimble_Base_Split_Final();
            translate([-Laser_Gimble_Cull_Width/2,(-Laser_Gimble_Cull_Width/2)+Tolerance,-10])
                cube([Laser_Gimble_Cull_Width,Laser_Gimble_Cull_Width/2, Gimble_Arm_Height * 2]);
        }
    }
}

module Gimble_Angle_Guide()
{
    GuideOrigin = origin + [0,0,Gimble_Arm_Height];
    translate(GuideOrigin)
    rotate([90,0,0])
    difference()
    {
        cylinder(d=(Gimble_Arm_Cuff_Diameter + Tolerance * 2) * 5, h= Laser_Gimble_Cull_Width - Gimble_Arm_Retraction - 1, center=true);
        cylinder(d=(Gimble_Arm_Cuff_Diameter + Tolerance * 2) * 2, h= Laser_Gimble_Cull_Width, center=true);
        cylinder(d=(Gimble_Arm_Cuff_Diameter + Tolerance * 2) * 5 + Tolerance, h= Laser_Gimble_Cull_Width - Gimble_Arm_Cuff_Diameter, center=true);
        echo ((Gimble_Arm_Cuff_Diameter + Tolerance * 2) * 5);
        rotate([-90,0,0])
translate(-GuideOrigin + [0,.2,0] )
                Gimble_Base_Split_V1();                
        translate([-Laser_Gimble_Cull_Width,-Laser_Gimble_Cull_Width,-Gimble_Arm_Height])
            cube([Laser_Gimble_Cull_Width*2,Laser_Gimble_Cull_Width*2, Gimble_Arm_Height]);
        translate([0,0,Gimble_Cuff_Center_Depth + 10])
        {
            for(angle = [5:10:360])
            {
                rotate([angle,90,0])
                translate([0,35,0])
                //rotate([angle-45,0,0])
                    cube([10,5,.1]);
            }
            for(angle = [0:10:360])
            {
                rotate([angle,90,0])
                translate([0,30,0])
                //rotate([angle-45,0,0])
                    cube([10,15,.1]);
            }
        }
    }
}

module Gimble_Angle_Guide2()
{
    GuideOrigin = origin + [0,0,Gimble_Arm_Height];
    translate(GuideOrigin)
    rotate([90,0,0])
    difference()
    {
        cylinder(d=(Gimble_Arm_Cuff_Diameter + Tolerance * 2) * 15, h= Laser_Gimble_Cull_Width - Gimble_Arm_Retraction - 1, center=true);
        cylinder(d=(Gimble_Arm_Cuff_Diameter + Tolerance * 2) * 5, h= Laser_Gimble_Cull_Width, center=true);
        cylinder(d=(Gimble_Arm_Cuff_Diameter + Tolerance * 2) * 15 + Tolerance, h= Laser_Gimble_Cull_Width - Gimble_Arm_Cuff_Diameter, center=true);
        //rotate([-90,0,0])
        //translate(-GuideOrigin + [0,.2,0] )
        //                #Gimble_Angle_Guide();                
        translate([-Laser_Gimble_Cull_Width*2.5,-Laser_Gimble_Cull_Width*2.5,-Gimble_Arm_Height])
            cube([Laser_Gimble_Cull_Width*5,Laser_Gimble_Cull_Width*5, Gimble_Arm_Height]);
        union()
        translate([0,0,Gimble_Cuff_Center_Depth + 10])
        {
            for(angle = [.5:1:360])
            {
                rotate([angle,90,0])
                translate([0,125,0])
                //rotate([angle-45,0,0])
                    cube([10,2.5,.2]);
            }
            for(angle = [5:10:360])
            {
                rotate([angle,90,0])
                translate([0,125,0])
                //rotate([angle-45,0,0])
                    cube([10,10,.2]);
            }
            for(angle = [0:1:360])
            {
                rotate([angle,90,0])
                translate([0,125,0])
                //rotate([angle-45,0,0])
                    cube([10,5,.2]);
            }
            for(angle = [0:10:360])
            {
                rotate([angle,90,0])
                translate([0,120,0])
                //rotate([angle-45,0,0])
                    cube([10,15,.2]);
            }
        }
        cube([200,200,100]);
        translate([-200,-200,0])
            cube([200,400,100]);
        translate([0,-80,25])
            cylinder(h=50, d=70, center=true);
        translate([80,0,25])
            cylinder(h=50, d=70, center=true);
        translate([70,-70,25])
            #cylinder(h=50, d=50, center=true);
    }
}

//Gimble_Base_Split_V1();
//Gimble_Base_Split_V2();
Gimble_Angle_Guide2();
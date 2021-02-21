////////////////////////////////////////////////
/////////////Open SCAD ////////////////////////
/*//////////////////////////////////////////////

date started  ///1.6.2020
date finished
modler @paradroid_
*/

/*

cylinder ([]) ;   sphere();  cube([]);
square ([]);  circle();

*/
///////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////parameters//////////////////
////////////////////////////////////////////////
//globals

//width=42;
//hight=147;
//length=10;
//
//width=36;
//hight=143;
//length=24.5;



////////////////////////////////////////////////
/////////////////////renders////////////////////
///////////////////////////////////////////////

ComplexObject();

////////////////////////////////////////////////
////////////////////modules////////////////////
///////////////////////////////////////////////
//cylinder ([]) ;   sphere();  cube([]);
//square ([]);  circle();

ChannelWidth = 4;
PlateSize = 280;
NumHoles = 12;
PlateRadius = PlateSize / 2;
PlateDepth = 15;
Tolerance = 0.75;
PlateRimHeight = 5;
PlateRimWidth = 10;

$fn = 100;
import();

module ComplexObject()
{
    difference()
    {    
        union()//Add things to object
       {
            translate([0,0,0])
            {
                cylinder(PlateDepth,r=PlateRadius);
            }
        }
    
        union()//Subtract things from object
        {
            translate([0,0,-Tolerance])
            {
                cylinder(PlateRimHeight + Tolerance,r=PlateRadius -PlateRimWidth);
            }
            Rotation_Angle = 360 / NumHoles;
            for(i = [0:1:NumHoles])
            {
                rotate([0,0,Rotation_Angle * i])
                {
                    translate([PlateRadius,0,(PlateDepth / 2) + Tolerance])
                    {
                        rotate([125,0,90])
                        {
                            cylinder(PlateSize + Tolerance,r= ChannelWidth, center=true);
                        }
                    }
                }
            }
        }
    }
}
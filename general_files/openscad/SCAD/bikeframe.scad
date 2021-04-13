////////////////////////////////////////////////
/////////////Open SCAD ////////////////////////
/*//////////////////////////////////////////////

date started  ///1.6.2020
date finished
modler Colin Gaby and John Bargman
/*


cylinder ([]) ;   sphere();  cube([]);
square ([]);  circle();
*/


///////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////parameters//////////////////
////////////////////////////////////////////////
//globals

A_angle=30;
B_angle=0;
C_angle=90;
Rod_A_length=443;
Rod_B_length=258;
Rod_C_length=390;
Rod_D_length=132;

Rod_A_width=38;
Rod_A_width_2=38.5;
Rod_B_width=29;
Rod_C_width=39;
Rod_D_with=37.2;



////////////////////////////////////////////////
/////////////////////renders////////////////////
///////////////////////////////////////////////

bikeframe();

////////////////////////////////////////////////
////////////////////modules////////////////////
///////////////////////////////////////////////
//cylinder () ;   sphere();  cube([]);
//square ([]);  circle();


$fn = 30;
//import();

module bikeframe()
{
difference()
    {
        union()//Add things to object

       {

// cylinder A

hull() {
  rotate([180,88,0]){
    translate([-38,0,-110]){
         translate([-100,0,255]){
               rotate([0,A_angle,0]){
                cylinder(Rod_A_length,Rod_A_width,Rod_A_width, center=true);
               }
               }
// cylinder A++
                        translate([-70,0,240]){
                              rotate([0,A_angle,0]){
                              cylinder(Rod_A_length,32,32, center=true);
                              }
                              }
                              translate([-112,0,267]){
                                    rotate([0,A_angle,0]){
                                     cylinder(Rod_A_length,32,32, center=true);
                                    }
                                    }

                        translate([-90,0,250]){
                              rotate([0,A_angle,0]){
                               #cylinder(Rod_A_length,38.5,38.5, center=true);
                              }
                              }

               // cylinder D
                        translate([-232,0,0]){
                              rotate([0,A_angle,0]){
                                cylinder(Rod_D_length,Rod_D_with,Rod_D_with, center=true);
                              }
                              }
                            }
                          }
}
// cylinder B
         rotate([B_angle,y ,z]){
         translate([170,0,120]){
           cylinder(Rod_B_length,Rod_B_width,Rod_B_width,center=true);
         }
       }
// cylinder C
       rotate([C_angle,y,z]){
        translate([50,0,-50]){
           cylinder(Rod_C_length,Rod_C_width,Rod_C_width,center=true);
           }
         }
         translate([-30,0,-10]){
         rotate([180]){
         scale([900,900,1100]){
#import("C:/Users/frank/Downloads/mikebike slice this one.stl");
         }
         }
         }


    
            union()//Subtract things from object
    {




}


  }




}
}

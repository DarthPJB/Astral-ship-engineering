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

Enclosure_width=300;
Enclosure_height=250;
Enclosure_depth=90;

Neg_Enclosure_width=160;
Neg_Enclosure_height=490;
Neg_Enclosure_depth=150;

////////////////////////////////////////////////
/////////////////////renders////////////////////
///////////////////////////////////////////////
use <bikeframe.scad>
use <BikeBatteryBoxCutout.scad>
ComplexObject();

////////////////////////////////////////////////
////////////////////modules////////////////////
///////////////////////////////////////////////
//cylinder () ;   sphere();  cube([]);
//square ([]);  circle();


$fn = 100;


module ComplexObject()
{
 bikeframe();
difference()
    {



        union()//Add things to object

       {

translate([-170,-40,-15]){
           cube([Enclosure_width,Enclosure_depth,Enclosure_height]);

        }
        rotate([0,-32,0]){
          translate([-150,-30,120]){
cube([Enclosure_width+80, Enclosure_depth,5]);
}
}
}
translate([-370,-90,110]){
translate([370,90,-110]){
  rotate([0,58,0]){
  BikeBatteryBoxCutout();
}
}
 translate([200,70,-115]){

            cube([Enclosure_width-5,Enclosure_depth-4,Enclosure_height-5]);
          }

          translate([-270,-40,-15]){
                    cube([Enclosure_width-5,Enclosure_depth-5,Enclosure_height-5]);
                   }
                  translate([-270,-40,-15]){
                   #cylinder([100,5,5]);
                 }
}
  }
}

////////////////////////////////////////////////
/////////////Open SCAD ////////////////////////
/*//////////////////////////////////////////////

date started  ///1.6.2020
date finished
modler Colin
/*


cylinder ([]) ;   sphere();  cube([]);
square ([]);  circle();
*/


///////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////parameters//////////////////
////////////////////////////////////////////////
//globals

width_controler=82.8;
length_controler=40.5;
height_controler=185;

width_controler_attachment=1;
length_controler_attachment=63.8;
height_controler_attachment=13;


////////////////////////////////////////////////
/////////////////////renders////////////////////
///////////////////////////////////////////////
ComplexObject();

////////////////////////////////////////////////
////////////////////modules////////////////////
///////////////////////////////////////////////
//cylinder () ;   sphere();  cube([]);
//square ([]);  circle();


$fn = 100;
//import();

module ComplexObject()
{
difference()
    {



        union()//Add things to object

       {
           cube([width_controler,height_controler,length_controler]);
           translate([10,-14,0]){
               rotate([0,90,0]){
           #cube([width_controler_attachment,height_controler_attachment,length_controler_attachment]);

           }
       }
       translate([10,185,0]){
               rotate([0,90,0]){
           cube([width_controler_attachment,height_controler_attachment,length_controler_attachment]);

           }
       }
}


            union()//Subtract things from object
    {
                   translate([60,-8,-5]){



         #cylinder (10,5,5);


               }
                translate([30,-8,-5]){



         #cylinder (10,5,5);
                }

 translate([42,190,-5]){



         #cylinder (10,5,5);
                }
                translate([18,190,-5]){



                        #cylinder (10,5,5);
                               }
                               translate([18,190,-5]){



                                       #cylinder (10,5,5);
                                              }

}


  }




}

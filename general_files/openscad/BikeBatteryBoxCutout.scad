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
Enclosure_width=300;
Enclosure_height=250;
Enclosure_depth=90;


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
           
cube([Enclosure_width-5,Enclosure_depth-4,Enclosure_height-5]);

           
           }
           
           
    
            union()//Subtract things from object
    {
       translate([-10,-5,-10]){
           rotate([0,95,0]){
           
       #cube([Enclosure_width+90,Enclosure_depth+10,Enclosure_height]);
       
                   }
               }
      
}
 

  }


    

}
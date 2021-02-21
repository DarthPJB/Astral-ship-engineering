

//globals or parameters

height=50;
radius=25;
//render
cup();
//modules
$fn=50;
module cup()
{
    // circle(d = 50);    
    translate([0,0,50])
    #rotate_extrude()
    translate([25,0,0])
    
     circle(d = 8);
    
    difference()
    {
        union()//add things to object 
        {
         //   #color(50,250,0)
            rotate([0,0,90]){
                    #cylinder (height-25, radius-3,radius-3);
            }

        cylinder (height, radius,radius);
                rotate_extrude($fn=10)
            {
                translate([0,25,50])
                {
                //rotate([0,90,0])
                circle(d = 50);            
                }
            }
        translate([25,0,23])
            rotate([90,0,0])
                rotate_extrude()
                    translate([15,0,0])
                        circle(d=7.25);
            
        }
    
    
        union()//remove things from object
        {
            translate([0,0,4])
            {
                cylinder (height-3.9,radius-4,radius-4);
            }
        } 
    }
}

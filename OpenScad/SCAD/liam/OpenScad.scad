translate([-5,0,0])
{
    union()
    {
         difference()
         {
            hull()
            {
                sphere(15,$fn=100);
                translate([0,9,0])
                    sphere(13,$fn=100);
            }
            translate([0,-10,0])
                sphere(11,$fn=100);
            translate([-10,-10,-33])
                cube(20);
        }
    }
}
$fn=10;
//hull()
{
    union()
    {
        for(count = [0:500])
        {
            rotate([0,0,10*count])
            translate([0,10*count,0])
            {
            
                cube(100);
            }
        }
    }
}
use<../../Laser_Mount/Laser Level.scad>


// Function: constrain()
// Usage:
//   constrain(v, minval, maxval);
// Description:
//   Constrains value to a range of values between minval and maxval, inclusive.
// Arguments:
//   v = value to constrain.
//   minval = minimum value to return, if out of range.
//   maxval = maximum value to return, if out of range.
function constrain(v, minval, maxval) = min(maxval, max(minval, v));

function Distance(a,b) = sqrt(pow(b[0] - a[0], 2) +	pow(b[1] - a[1], 2) +	pow(b[2] - a[2], 2));



//Beam defaults to bottom right corner
module SquareBeam(Start = [0,0,0], End = [0,0,0], Width=10, Height=10, centerWidth = true, centerHeight=true, ExtraLenth = 0)
{
    if(Start != End )
    { 
    Length = Distance(Start,End);
    Vector = End - Start;

    b = acos(Vector[2]/Length); // inclination angle
    c = atan2(Vector[1],Vector[0]);     // azimuthal angle

    echo(Length, Vector, "[",0,b,c,"]");
    translate(Start)
        rotate([0,b,c])
            translate([centerWidth==true ? -Width / 2 : 0,0,0])
                translate([0,centerHeight==true ? -Height / 2 : 0, -ExtraLenth / 2])
                    cube([Width,Height, Length + ExtraLenth], center = false);
    }
}

// Expect Origin position to be [[X,Y,Z], [Roll, Pitch, Yaw]
// Expected A set of data in the format of [[Yaw, Pitch, Distance], ...] 
// Optional Rendering Colour
module PointSet(Origin = [[0,0,0],[0,0,0]], ModuleTestData = [[0,0,0]], Colour = "blue",Cube_Size = 50, beam_render = true)
{
    Beam_additional_offset = 5;
    color(Colour)
    translate(Origin[0])
    {
            if($preview == false)
                LaserLevel();
            else
                cube(100, center = true);
            for( c = ModuleTestData)
            {
                //Rotate to match laser-measure
                rotate([0,c[1]-90, -c[0]] + Origin[1])
                {
                    if(beam_render == true)
                    {
                        cube([c[2] + Beam_additional_offset ,1,1]);
                    }
                    //Translate to a distance
                    translate([c[2] + Beam_additional_offset,0,0])
                        //Correct Cube rotation to be static
                        rotate([0,90-(c[1]-90), c[0]])
                            cube(Cube_Size, center = true);   
                }

            }
    }
}
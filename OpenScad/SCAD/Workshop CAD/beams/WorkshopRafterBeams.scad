use<../lib/Workshop_Utility.scad>

//The most sane modeling practice will use this as the origin of the entire building.

// This Point is located on the Central_Pillar.
// Towards the Side facing towards Denorwig
// when facing this surface, the top edge
// where it meets the ceiling, in the center of this edge
// this is the origin of the... ASTRAL-SHIP

module Rafters(Origin = [-1935,0,2365])
{
    echo("Drawing Rafters");
    //cube([200,0,0]);
    translate(Origin)
    {
        //Central Pillar
        Pillar_Width =375;
        Pillar_Depth = 275;
        // Ceiling / crossbeam offset
        Ceilng_To_Beam_Base =- 85;
        Roof_Beam_Depth = 100;
        Beam_Center_Height = -2365;

        // Central Pillar Beam
        SquareBeam([0,0,0], [0,0,Beam_Center_Height], Pillar_Width, Pillar_Depth, false, true);


        translate([0,0, Ceilng_To_Beam_Base- Roof_Beam_Depth])
        {
            //Beam to workshop exterior entrance
            SquareBeam([0,0,  Roof_Beam_Depth - Ceilng_To_Beam_Base], [5115,0, Roof_Beam_Depth - Ceilng_To_Beam_Base], Roof_Beam_Depth * 2, 196, true, true);
            //beam supporting Previous (from pillar)
            translate([0,0,-Ceilng_To_Beam_Base])
                SquareBeam([0,0,-531], [531,0,0], 200, 75, false, true, 400);
            

            translate([-Pillar_Width / 2,Pillar_Depth/2, 0])
            {
                //beam towards exterior wall (stairway)
                SquareBeam( [0,0,  Roof_Beam_Depth - Ceilng_To_Beam_Base], 
                            [0,3517,  Roof_Beam_Depth - Ceilng_To_Beam_Base], Roof_Beam_Depth * 2, 196, true, true);
                
                //beam supporting Previous (from pillar)
                translate([0,0,-Ceilng_To_Beam_Base])
                    SquareBeam([0,0,-531], [0, 531 ,0], 200, 75, false, true, 400);
            }

            translate([-Pillar_Width / 2,-Pillar_Depth/2, 0])
            {
                //beam towards adjoining wall (chapel)
                SquareBeam( [0,0,  Roof_Beam_Depth - Ceilng_To_Beam_Base], 
                            [0,-3395,  Roof_Beam_Depth - Ceilng_To_Beam_Base], Roof_Beam_Depth * 2, 196, true, true);
                
                //beam supporting Previous (from pillar)
                translate([0,0,-Ceilng_To_Beam_Base])
                    SquareBeam([0,0,-531], [0, -531 ,0], 200, 75, false, true, 400);

            }
            translate([-Pillar_Width,0, 0])
            {
                //Beam to workshop exterior entrance
                SquareBeam([0,0,  Roof_Beam_Depth - Ceilng_To_Beam_Base], [-5129,0,  Roof_Beam_Depth - Ceilng_To_Beam_Base], Roof_Beam_Depth * 2, 196, true, true);

                //beam supporting Previous (from pillar)
                translate([0,0,-Ceilng_To_Beam_Base])
                    SquareBeam([0,0,-531], [- 531,0,0], 200, 75, false, true, 400);
            }
        }
        translate([0,0,0])
        {
            
        }
    }

}

Rafters();
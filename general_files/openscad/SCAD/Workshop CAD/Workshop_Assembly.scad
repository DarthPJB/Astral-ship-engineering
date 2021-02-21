// Workshop rafter point-data; 
// This file should be used by a higher level file
// to better represent the data.

// The data will be devided into sets; such that important structures are recorded together, with their own unique origin point, witch is referenced to world-co-ordinates. 
// This should allow for rapid recoring and efficient matrix transformation to final CAD data.
$fn = 5;

use<lib/Workshop_Utility.scad>
use<beams/WorkshopRafterBeams.scad>

Origin_one = [[-1935,0,0993],[0,5,0]];


Test_Set_One = [
    //    [Yaw, Pitch, Distance]

    //Test Data
    [0,90,5740],
    [0,120,3417],
    [0,130,2543],
    [0,150,1790],


    //Test  Data Set 2
    [0,115,3912],
    [352.5,115,3953],
    [14,86,3364],
    [23,85.5,3531],

    [53,86,4858],
    [52,94,4771],
 
    //John reading test data 1
    [89,86,4446],
    [100,86,4458],
    //[94.5,86,44x5],
    [100,100.5,4411],
    [89,100.5,4382],
    [89,115,4563],
    [100,114.5,4567],
    [101,118,4104],
    [86,116.5,3877],
    [87,83.5,3756],
    [102,84.5,3876]];

Test_Set_Two = [

        // Start with the wall above the stairs
    [280,87,3774],
    [280,92,3735],
    [280,96,3714],

        //Base of the stairs
    [264,125,3095],
    [255,119,4011],
    [255,102,3944],
    [269.5,103,3808],
    [270,84,3912],
    [270,115,2758],
    [270,122,2884],
    [275,120,2706],
    [280,104.5,2690],
    [280,113,2748],
    [290,100,2800],
    [290,94,2817],
    [300.5,808.5,3075],
    [300,82.5,3131],
    [302,82,3209],
    [306,82,3349],
];

Test_Set_Three = [
    [314,87,5037],
    [54,87,5013],
    [211,91,8132],
    [156,90,8146],
    [0,150,1815],
    [0,0,0908],
    [0,83,3345],
    [0,85.5,3385],
    [355,85.5,3413],
    [14,85,3393],
    [180,73,2139],
    [180,90,1935],
    [251,73,2272]

];

Origin_two = [[-1935,0,0993],[0,0,5]];
Test_Set_Four = [
    // Edge of wall    
    [300, 78,   5054],
    [300, 104,  5169],
    [300, 94,   5014],
    [300, 98,   5052],
    //the window
    [309, 77.5, 5062],
    [309, 81,   5056],
    [309, 85,   4975],
    [309, 87,   4958],

    [282, 87.5, 4193],
    [287, 87.5, 4328],
    [289.5, 88.5, 4484],
    [295, 89,     4817],
    [295.5, 87.2, 4813],
    [230, 88,     4816],
    [305, 87.5,   4846],
    [305, 84.2, 4846],
    [10, 86, 3382]
];

Origin_Three = [[-3062, -1135, 0863 + 85],[0,0,-4]];
Test_Set_Five = [
    [165,   74,      3356],
    [165.5, 74.5,    3357],
    [165,   90,      3245],
    [165,   92.5,    3247],
    [266,   92.5,    1533],
    [316,   92.5,    3163],
    [316,   87.5,    3169],
    [316,   82.5,   3194],
    [316,   79,     3233],
    [316,   76,     3286],
    [200,   76.5,   3479],
    [196.5, 99,     9101],
    [196.5, 91.5,   8953],
    [196.5, 90,     8964],
    [196.5, 88,     8962],
    [196.5, 85.2,   8955],
    [198,   85,     8875],
    [198,   88,     8896],
    [198,   89.5,   8858],
    [191,   89,     8655],
    [191,   86,     8674],
    [191,   85,     8693],
    [190,   86.5,   8658],
    [180,   86.5,   8630],
    [184,   86.5,   8608],
    [182,   86.5,   8607],
    [179,   86.5,   8642],
    [190,   84.5,   8680],
    [186,   84.5,   8636],
    [182,   84.75,  8631],
    [179,   84.75,  8671],
    //test set for beam
    [150,   77,     3903],
    [145,   77.7,   4172],
    [138,   79,     4585],
    [135,   79.5,   5084],
    [127,   81,   5765]
];

Test_Set_Six = [
    [0,0,0]
];

module Workshop_Assembly(Cube_Size = 50, draw_beams = false)
{
    Rafters([0,0,0]);
    PointSet(-Origin_one, Test_Set_One, [1,0,0,0.5], Cube_Size, draw_beams);
    PointSet(-Origin_one, Test_Set_Two, [1,0,0,0.5], Cube_Size, draw_beams);
    PointSet(-Origin_one, Test_Set_Three, "blue", Cube_Size, draw_beams);
    PointSet(-Origin_two, Test_Set_Four, "yellow", Cube_Size, draw_beams);
    PointSet(-Origin_Three, Test_Set_Five, "cyan", Cube_Size, draw_beams);
    PointSet(-Origin_Three, Test_Set_Six, "cyan", Cube_Size, draw_beams);
}

Workshop_Assembly(50, true);

color([.5,.5,.5,.1])
hull()
{
    Workshop_Assembly();
}
wall_width=10800; //X
wall_height=7100; //Y
wall_length=2300; //Z

translate([-5500,-3540,-2000]){
cube([wall_width,wall_height,wall_length]);
    
  
}

translate([1000,-4400,-3000]){

  #cube([1000,500,3000]);
}
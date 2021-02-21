// Laser measure recreation
// John Bargman & Colin 2020-11-19

// All measurements in millimeters

//Set to height detail only for rendering:
$fn= $preview == true? 20 : 30;
minkowskiRound = 1;

Width=52;
Depth=115.5;
Height=29;

Tolerance = 0.2;
origin = [0,0,0];

module Laser_Measure()
{
    translate(origin)
      union()
      {
          minkowski()
          {
            cube([Width - (minkowskiRound*2), Depth- (minkowskiRound*2), Height- (minkowskiRound*2)], center = true); 
            sphere(r=minkowskiRound);    
          }
      }
}

Laser_Measure();
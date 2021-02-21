// PropRep.scad - library for parametric propellers and repellers 
//                with Naca airfoil data
// Code: Rudolf Huttary, Berlin 
// Sept 2015
// commercial use prohibited

use <shortcuts.scad>
use <naca4.scad>

$fn=100; 
Ty(40) Propeller(); Repeller(); // compare with default values

//// please note module signature output in console.
//// Repeller and Propeller modules use the same parameters 
////   and differ in defaults only!

//// some examples for usage. Uncomment to test. 
// Propeller(n=4); // 4 blades
// Propeller(n=3, CCW=true); // 3 blades counter clockwise
// Repeller(n=3, CCW=true); // 3 blades counter clockwise
// Propeller(rAx=3, lAx=30, tip_scale = 1, twist=60, rot=-50); // set bore and no narrowing towards tip
// Propeller(r1Ax=5, L=10); // skinny
// Repeller(r1Ax=15, lAx=30, naca=2440); // a fat one for water use
// Propeller(twist = -20, rot = -70, L=28, lAx=13); // a flat one for microkopter
// Propeller(n=5, tip_scale=.6); Ry(90) Ri(102, 100, 20);  // Childrens toy
// D(){ Propeller(n=12, twist = -30, rot=-20, L=20, tip_scale=3, naca=1408); Ry(90) Ri(110, 100, 60); } // fan

//  D(){ Repeller(n=6, twist=40, L=20, tip_scale=3, naca=1408); Ry(90) Ri(110, 100, 60); } // ducted repeller


module Repeller(rAx=4, r1Ax=13, lAx=26, n=2, tip_scale=[.3,.2], L=30, r=100, twist=60, rot=30, naca = [.1, .4, .12], CCW = false)
{
  mirror([0,CCW?0:1, 0])
  PropRep(rAx, r1Ax, lAx, n, tip_scale, L, r, twist, rot, naca); 
}

module Propeller(rAx=4, r1Ax=13, lAx=26, n=2, tip_scale=[.3,.2], L = 30, r = 100, twist=-60, rot=-30, naca = [.1, .5, .12], CCW = false)
{
  mirror([0,CCW?1:0, 0])
  PropRep(rAx, r1Ax, lAx, n, tip_scale, L, r, twist, rot, naca); 
}


module PropRep(rAx, r1Ax, lAx, n, tip_scale, L, r, twist, rot, naca)
{
  help(); 
  D()
  {
    U()
    {
      for(w=[0:360/n:359])
        R(w)
        proprep(tip_scale, L, r, twist, rot, naca);
      Ry(90)
      Cy(r1Ax, lAx);
    }
    Ry(90)
    Cy(rAx, lAx+1); 
  }
}

module proprep(tip_scale, L, r, twist, rot, naca)
{
    Rz(-rot)
      linear_extrude(height = r, scale = tip_scale, twist=twist, convexity = 4)
      T(-L/2)
      polygon(points = airfoil_data(naca=naca, L = L)); 
}


module help()
{
  echo(str("\nLIBRARY PropRep - by Rudolf Huttary 2015\n", 
  "  Repeller(rAx=4, r1Ax=13, lAx=26, n=2, tip_scale=[.3,.2], L=30, r=100, twist=60, rot=30, naca = [.1, .4, .12], CCW = false)\n",  
  "  Propeller(rAx=4, r1Ax=13, lAx=26, n=2, tip_scale=[.3,.2], L=30, r=100, twist=-60, rot=-30, naca = [.1, .5, .12], CCW = false)\n", 
  "  PropRep(rAx, lAx, n, tip_scale, L, r, twist, rot, naca) --- blade with hub\n", 
  "  proprep(tip_scale, L, r, twist, rot, naca) --- blade only\n", "********")); 
}


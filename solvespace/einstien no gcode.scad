difference(){
import("/home/john/Downloads/Albert_Einstein_highres.stl");
    translate([5,-10,-102])
    {
        cube([150,150,19]);
    }
}
translate([5,-10,-102])
    translate([-20,-50,0])
        cylinder(d=5,20);
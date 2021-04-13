use <MCAD/boxes.scad>

outerD=30;
innerC=5;
length=60;
translate ([length,0,0]) difference(){
    roundedBox(size=[outerD,outerD,10], radius=4,center=true);
    translate([0,0,9.8]) cylinder (10,innerC,5, center=true);
}

difference(){
    roundedBox(size=[outerD,outerD,10], radius=4,center=true);
    translate([0,0,9.8]) cylinder (10,innerC,5, center=true);
}

translate ([25,0,0]) rotate ([0,90,0]) roundedBox (size=[8,10,length],radius=3.5,sidesonly=true);
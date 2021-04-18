printed_text = "Created by @ASTRAL_3D";

module lid()
{
    difference()
    {
        import("./output/casing0.stl");
    translate([410,30,68])
        rotate([0,0,180])
            scale([1.5,1.5,1])
                linear_extrude(4)
                    text(printed_text);
    }
}
module casing()
{
    difference()
    {
    import("./output/casing1.stl");
    translate([170,30,-6])
        rotate([0,0,180])
            scale([-1.5,1.5,1])
                linear_extrude(4)
                    text(printed_text);
    }
}

//lid();
casing();
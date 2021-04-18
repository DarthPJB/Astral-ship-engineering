import cadquery as cq
from cadquery import exporters
from cadquery import importers



## ----------- Core variables --------------------------------------------------    ---                     Variable initialisation
fit_tolerance_bike = 2;
box_corner_fillet = 15;
box_wall_thickness = 5;

#internal width (height of 18650 batteries)
box_total_width = 70;

screw_thread_diam = 5;
screw_post_diam = screw_thread_diam + 3;
screw_depth = 40;
screw_cap_diam = 9.1;
screw_cap_height = 1;

Cable_hole_diam = 20;
Cable_hole_position_X = 500
Cable_hole_position_Y = box_total_width/2;
Cable_hole_position_Z = 230;
Cable_hole_angle = 50;

cut_text_position_x = 310;
cut_text_position_y = 120;
cut_text_angle = 24;
cut_text = "Created By @Astral_3D";
cut_font="Trueno Bold";
cut_fontPath="truenobd.otf"
## ------------- Setup Variables -----------------------------------------------    ---                     Point Lists

# generate points list from the angle and length of the constraining edges (TODO: should import from svg)
points_list = [];
#first edge from 0,0 running along the top of the box.
points_list.append([475, 0]);
# second edge moving down the back of the bike-frame
points_list.append([250, 82.48]);
#edge up towards meeting the triangle
points_list.append([150.52, points_list[1][1] + 127.04 ]);


# define per-step differences for screw-hole placement (TODO: generate these according to generative geometary)
edge_difference_x = 60;
rising_x_offset = 54;
rising_y_offset = 25.25;
falling_x_offset = 8;
falling_y_offset = 60;

screw_placement_points = [
    (455, 8), # Top Left Corner
    (93, 34), # Top Right corner
    (495, 205), # Bottom Left Corner

    #Holes at 60mm intervals along top-edge
    (400, 8),
    (340, 8),
    (280, 8),
    (220, 8),
    (160, 8),
    (100, 8),

    #Holes along diagnal edges
    (93 + rising_x_offset , 34 + rising_y_offset),
    (93 + rising_x_offset * 2 , 34 + rising_y_offset * 2),
    (93 + rising_x_offset * 3, 34 + rising_y_offset * 3),
    (93 + rising_x_offset * 4 , 34 + rising_y_offset * 4),
    (93 + rising_x_offset * 5, 34 + rising_y_offset * 5),

    #Second diagnal edge requires some tweaking.
    (93 +  rising_x_offset * 6 , 34 + 2 + rising_y_offset * 6),
    (93 +  rising_x_offset * 7 , 34 + 8 + rising_y_offset * 7),

    #rising edge has a slight angle
    (495 - falling_x_offset , 205 - falling_y_offset),
    (495 - falling_x_offset*2 , 205 - falling_y_offset*2),
    (495 - falling_x_offset*3 , 205 - falling_y_offset*3),
];

# ---------- Generate Core Geometary -------------------------------------------    ---                     MESH GENERATION

#initial workplane generation
perimeter = cq.Workplane("XY");

# Generate plane containing wire-loop                                               ---                     WIRE LOOP
for point in points_list:
    perimeter = perimeter.polarLine(point[0],point[1]);
# Close wire-loop of measured perimeter
perimeter = perimeter.close();

# shrink the wire-loop to handle tolerance and wall box_wall_thickness
casing_edge = perimeter.edges().offset2D(-(fit_tolerance_bike + box_wall_thickness))
# Extrude edge to make casing shape
casing_geometry = casing_edge.extrude(box_total_width);#                            ---                     Casing Geometary
# fillet edges to make for nice-curved ends
casing_geometry = casing_geometry.edges("|Z").fillet(box_corner_fillet);
# Shell the casing to make the inside hollow.
casing_geometry = casing_geometry.shell(box_wall_thickness,"arc");

# Split casing_geometry into top and bottom parts
# (top being the thin lid, bottom being the box-casing itself)                      ---                     Casing Split
casing_top = casing_geometry.faces(">Z").workplane(-box_wall_thickness).split(keepTop=True)
casing_bottom = casing_geometry.faces(">Z").workplane(-box_wall_thickness).split(keepTop=False,keepBottom=True);


# In the top plate, cut holes for the screws to enter the casing through.           ---                     Top lid screw placement
casing_top =  casing_top.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_thread_diam/2).cutThruAll()
# In the top plate, sink holes for the screw-heads to be recessed slighty.
casing_top =  casing_top.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_cap_diam/2).cutBlind(-screw_cap_height)

# In the bottom box, add the screw-posts                                            ---                     Bottom casing screw placement
casing_bottom = casing_bottom.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_post_diam/2).extrude(-box_total_width)
# then remove the screw-holes from the posts
casing_bottom = casing_bottom.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_thread_diam/2).cutBlind(-screw_depth)

# Position a workplane above the edges that need cutting
casing_cable_cut = cq.Workplane("YZ").transformed(
    offset=cq.Vector(Cable_hole_position_Z,Cable_hole_position_Y,Cable_hole_position_X),
    rotate=cq.Vector(0,Cable_hole_angle,0));
# Create a cylinder to represent the material to be removed by the cut.
casing_cable_cut = casing_cable_cut.circle(Cable_hole_diam/2).extrude(-50)

# Subtract the resulting geometary.
casing_bottom = casing_bottom.cut(casing_cable_cut);

# place workplane in correct location
text = cq.Workplane("XY").transformed(
    offset=cq.Vector(cut_text_position_x,cut_text_position_y,box_total_width + box_wall_thickness/2),
    rotate=cq.Vector(0,0,180 + cut_text_angle));
#generate text for the lid
text = text.text(cut_text, 10, box_wall_thickness/2, font=cut_font, fontPath=cut_fontPath)
# place workplane in correct location
text2 = cq.Workplane("XY").transformed(
    offset=cq.Vector(cut_text_position_x,cut_text_position_y, -box_wall_thickness / 2),
    rotate=cq.Vector(180,0, -cut_text_angle));
#generate text for the base
text2 = text2.text(cut_text, 10, box_wall_thickness/2, font=cut_font, fontPath=cut_fontPath)

casing_top = casing_top.cut(text);
casing_bottom = casing_bottom.cut(text2);
## Render resulting geometary
show_object(casing_bottom)
show_object(casing_top)
#show_object(text2)

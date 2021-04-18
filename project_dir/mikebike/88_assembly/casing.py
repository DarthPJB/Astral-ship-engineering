import cadquery as cq
from cadquery import exporters
from cadquery import importers

fit_tolerance_bike = 2;
box_corner_fillet = 15;
box_wall_thickness = 5;
#internal width (height of 18650 batteries)
box_total_width = 65;

screw_thread_diam = 5;
screw_post_diam = screw_thread_diam + 3;
screw_depth = 40;
screw_cap_diam = 9.1;
screw_cap_height = 1;


## ------------- Setup Variables

# generate points list from the angle and length of the constraining edges (TODO: should import from svg)
points_list = [];
#first edge from 0,0 running along the top of the box.
points_list.append([475, 0]);
# second edge moving down the back of the bike-frame
points_list.append([250, 82.48]);
#edge up towards meeting the triangle
points_list.append([150.52, points_list[1][1] + 127.04 ]);
#final line not used, meets origin from last edge.
#points_list.append([414.86, points_list[2][1] - 4.76 ]);

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
#(495 - falling_x_offset*4 , 205 - falling_y_offset*4),

];

# ---------- Generate Core Geometary
perimeter = cq.Workplane("XY");
perimeter2 = cq.Workplane("XY");
# Generate plane containing wire-loop
for point in points_list:
    perimeter = perimeter.polarLine(point[0],point[1]);
    perimeter2 = perimeter2.polarLine(point[0],point[1]);
perimeter = perimeter.close()
perimeter2 = perimeter2.close()

# shrink the wire-loop to handle tolerance and wall box_wall_thickness
casing_edge = perimeter.edges().offset2D(-(fit_tolerance_bike + box_wall_thickness))
# Extrude edge to make casing shape
casing_geometry = casing_edge.extrude(box_total_width);
# fillet edges to make for nice-curved ends
casing_geometry = casing_geometry.edges("|Z").fillet(box_corner_fillet);
# Shell the casing to make the inside hollow.
casing_geometry = casing_geometry.shell(box_wall_thickness,"arc");

casing_top = casing_geometry.faces(">Z").workplane(-box_wall_thickness).split(keepTop=True)
casing_top =  casing_top.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_thread_diam/2).cutThruAll()
casing_top =  casing_top.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_cap_diam/2).cutBlind(-screw_cap_height)

casing_bottom = casing_geometry.faces(">Z").workplane(-box_wall_thickness).split(keepTop=False,keepBottom=True);
casing_bottom = casing_bottom.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_post_diam/2).extrude(-box_total_width)
casing_bottom = casing_bottom.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_thread_diam/2).cutBlind(-screw_depth)

show_object(casing_top)
show_object(casing_bottom)

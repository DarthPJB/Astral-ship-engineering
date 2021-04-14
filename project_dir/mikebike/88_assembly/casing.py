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
screw_cap_diam = 9.5;
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

Difference_value = box_wall_thickness + screw_post_diam/2;
screw_placement_points = [
(473 - Difference_value, Difference_value),
(Difference_value + 175 ,Difference_value -2),
(Difference_value + 78, Difference_value + 8),
(Difference_value + 175 , Difference_value + 68),
(Difference_value + 300, Difference_value + 126),
(Difference_value + 300, Difference_value -2),
(Difference_value + 400, Difference_value + 176),
(Difference_value + 474, Difference_value + 100),
(Difference_value + 480, Difference_value + 210)];

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
casing_top =  casing_top.faces(">Z").workplane().pushPoints(screw_placement_points);
casing_top = casing_top.circle(screw_thread_diam/2).cutThruAll()
casing_top =  casing_top.faces(">Z").workplane().pushPoints(screw_placement_points);
casing_top = casing_top.circle(screw_cap_diam/2).cutBlind(-screw_cap_height)

casing_bottom = casing_geometry.faces(">Z").workplane(-box_wall_thickness).split(keepTop=False,keepBottom=True);
casing_bottom = casing_bottom.faces(">Z").workplane().pushPoints(screw_placement_points);
casing_bottom = casing_bottom.circle(screw_post_diam/2).extrude(-box_total_width)
casing_bottom = casing_bottom.faces(">Z").workplane().pushPoints(screw_placement_points);
casing_bottom = casing_bottom.circle(screw_thread_diam/2).cutBlind(-screw_depth)

screw_placements =  casing_bottom.faces(">Z").workplane().pushPoints(screw_placement_points);
screw_placements = screw_placements.circle(screw_post_diam/2)


#for x in range(8):
#    if(x != 6):
#        screw_posts = screw_posts.add(screw_placements.item(x).vertices().circle(screw_post_diam/2).extrude(-80))
#screw_posts = screw_posts.wire()#.extrude(box_total_width)

#show_object(screw_placements)
show_object(casing_top)
show_object(casing_bottom)

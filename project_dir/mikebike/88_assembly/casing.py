import cadquery as cq
from cadquery import exporters
from cadquery import importers

fit_tolerance_bike = 2;
box_corner_fillet = 15;
box_wall_thickness = 5;
box_total_width = 85;


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


# ---------- Generate Core Geometary

result = cq.Workplane("XY");
# Generate plane containing wire-loop
for point in points_list:
    result = result.polarLine(point[0],point[1]);
perimeter = result.close()

# shrink the wire-loop to handle tolerance and wall box_wall_thickness
casing_edge = perimeter.edges().offset2D(-(fit_tolerance_bike + box_wall_thickness))
# Extrude edge to make casing shape
casing_geometry = casing_edge.extrude(box_total_width -  box_wall_thickness * 2);
# fillet edges to make for nice-curved ends
casing_geometry = casing_geometry.edges("|Z").fillet(box_corner_fillet);
# Shell the casing to make the inside hollow.
casing_geometry = casing_geometry.shell(box_wall_thickness,"arc");

#casing_top = casing_geometry.faces(">Z").workplane(-box_wall_thickness).split(keepTop=True)
casing_bottom = casing_geometry.faces(">Z").workplane(-box_wall_thickness).split(keepTop=False,keepBottom=True);




show_object(casing_bottom)

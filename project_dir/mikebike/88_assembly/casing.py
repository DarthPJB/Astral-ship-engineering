# Mike-Bike battery-box casing, by the Astral_3D Team aboard the Astral Ship, 2021-05-15
# Expecting CQ-Editor 0.2.0 or heigher, Cadquery 2.0.0
# This is version 3.0 of the battery-box design, a third prototype based heavily
# on the amazing work of our team!

import cadquery as cq
from cadquery import exporters
from cadquery import importers

DEBUG_MODE = True;

## ----------- Core variables --------------------------------------------------    ---                     Variable initialisation
fit_tolerance_bike = 2; #offset from bike-frame to allow human-fitting
fit_tolerance_casing = 0.1; # offset between meeting-faces to allow for print-error
box_corner_fillet = 15; # size of edge-ring filleting
box_wall_thickness = 5; # thickness of casing walls

lid_casing_split_distance = 10;


#Settings for Cut-GENERATION
Maximum_Size = [600,400,100]

#Settings for lapping of casing
Lapping_Offset = box_wall_thickness
double_Fit_Tolerance = fit_tolerance_casing * 2;
lapping_Thickness = (box_wall_thickness+double_Fit_Tolerance)/2

#internal width (height of 18650 batteries)
box_total_width = 70; # Internal height of the box.

screw_thread_diam = 5; # Screw Thread diameter for connecting face-plate to casing
screw_post_diam = screw_thread_diam + box_wall_thickness; # screw-post-width pre-calulation

screw_depth = 40;   # length of screw-fitting into the box itself
screw_cap_diam = 9.1; # Size of screw-cap for recessed fitting
screw_cap_height = 1; # Number of milimemeters to recess the screw-caps

Cable_hole_diam = 20; # Size of the cable-hole (20mm is a good fit for cable-plugs)
Cable_hole_position = cq.Vector(500,box_total_width/2, 230);
Cable_hole_angle = 50;

cut_text_position_x = 180;
cut_text_position_y = 60;
cut_text_angle = 24;
# Text to be placed on the box - note custom font use, should be in CQ's working path
cut_text = "Created By @Astral_3D";
cut_font = "Trueno Bold";
cut_fontPath = "truenobd.otf"
## ------------- Setup Variables -----------------------------------------------    ---                     Point Lists

# generate points list from the angle and length of the constraining edges (TODO: should import from svg)
points_list = [];
#first edge from 0,0 running along the top of the box.
points_list.append([463.6, 0]);
# second edge moving down the back of the bike-frame
points_list.append([250, 82.48]);
#edge up towards meeting the triangle
points_list.append([150.52, points_list[1][1] + 127.04 ]);

Bezier_Cut_Points = [
    (300.0, 70.0),
    (275.0, 100),
    (300.0, 150),
    (300.0, 200)
]
# define per-step differences for screw-hole placement                              --- TODO: generate these according to generative geometary
edge_difference_x = 60;
rising_offset = [55, 26.5];
rising_offset2 = [-9.5,-0.5]
falling_offset = [8,60];
FirstRisingScrew = [93,34];
FirstFallingScrew = [482,205];

screw_placement_points = [
    (450, 8), # Top Left Corner
    (93, 34), # Top Right corner
    (482, 205), # Bottom Left Corner

    #Holes at 60mm intervals along top-edge
    (400, 8),
    (340, 8),
    (280, 8),
    (220, 8),
    (160, 8),
    (100, 8),

    #Holes along diagnal edges
    (FirstRisingScrew[0] + rising_offset[0] , FirstRisingScrew[1] + rising_offset[1]),
    (FirstRisingScrew[0] + rising_offset[0] * 2 , FirstRisingScrew[1] + rising_offset[1] * 2),
    (FirstRisingScrew[0] + rising_offset[0] * 3, FirstRisingScrew[1] + rising_offset[1] * 3),
    (FirstRisingScrew[0] + rising_offset[0] * 4 , FirstRisingScrew[1] + rising_offset[1] * 4),
    (FirstRisingScrew[0] + rising_offset[0] * 5, FirstRisingScrew[1] + rising_offset[1] * 5),

    #Second diagnal edge requires some tweaking.
    (FirstRisingScrew[0] + rising_offset2[0] + rising_offset[0] * 6 , FirstRisingScrew[1]  + rising_offset2[1] + rising_offset[1] * 6),
    (FirstRisingScrew[0] + rising_offset2[0] * 2 + rising_offset[0] * 7 , FirstRisingScrew[1]  + rising_offset2[1] * 2 +rising_offset[1] * 7),

    #rising edge has a slight angle
    (FirstFallingScrew[0] - falling_offset[0] , FirstFallingScrew[1] - falling_offset[1]),
    (FirstFallingScrew[0] - falling_offset[0]*2 , FirstFallingScrew[1] - falling_offset[1]*2),
    (FirstFallingScrew[0] - falling_offset[0]*3 , FirstFallingScrew[1] - falling_offset[1]*3),
];

# ---------- Generate Core Geometary -------------------------------------------    ---                     MESH GENERATION

# place workplane in correct location                                               ---                 Generate Text Inverse volumes
text = cq.Workplane("XY").transformed(
    offset=cq.Vector(cut_text_position_x,cut_text_position_y, box_total_width + box_wall_thickness/2),
    rotate=cq.Vector(0,0,180 + cut_text_angle))\
.text(cut_text, 10, box_wall_thickness/2, font=cut_font, fontPath=cut_fontPath); #generate text for the lid
# place workplane in correct location
text2 = cq.Workplane("XY").transformed(
    offset=cq.Vector(cut_text_position_x,cut_text_position_y, -box_wall_thickness / 2),
    rotate=cq.Vector(180,0, -cut_text_angle))\
.text(cut_text, 10, box_wall_thickness/2, font=cut_font, fontPath=cut_fontPath) ; #generate text for the base

text_cut_volume = text.union(text2);
if DEBUG_MODE: debug(text_cut_volume, name='text-cutting volume');

# Generate the Spline-bezier cut and repepeat to creat lapping pannels              ---                     Creating lapping pannel Inverse-Geometary
Cut_Volume = cq.Workplane("XY").workplane(-lapping_Thickness*2).center(Lapping_Offset,0)\
.lineTo(Maximum_Size[0]/2, 0).spline(Bezier_Cut_Points,includeCurrent=True).lineTo(0,Maximum_Size[1]/2).close()\
.extrude(lapping_Thickness);

Cut_Volume2 = cq.Workplane("XY").workplane(lapping_Thickness + box_total_width).center(Lapping_Offset,0)\
.lineTo(Maximum_Size[0]/2, 0).spline(Bezier_Cut_Points,includeCurrent=True).lineTo(0,Maximum_Size[1]/2).close()\
.extrude(lapping_Thickness);

Cut_Volume3 = cq.Workplane("XY").workplane(-(lapping_Thickness + fit_tolerance_bike))\
.lineTo(Maximum_Size[0]/2, 0).spline(Bezier_Cut_Points,includeCurrent=True).lineTo(0,Maximum_Size[1]/2).close()\
.extrude(box_total_width + lapping_Thickness * 3 + double_Fit_Tolerance);

Cut_Volume = Cut_Volume.union(Cut_Volume3).union(Cut_Volume2);

if DEBUG_MODE : debug(Cut_Volume, name='bezier-seperation volume');
#Generate Inverse Geometary                                                         ---                     Creating opposite lapping pannel Inverse-Geometary
Inverse_Cut_Volume = cq.Workplane("XY").workplane(-box_wall_thickness*2).center(Maximum_Size[0]/2,Maximum_Size[1]/2)\
.rect(Maximum_Size[0], Maximum_Size[1], centered=True).extrude(Maximum_Size[2])\
.cut(Cut_Volume.translate(cq.Vector(double_Fit_Tolerance,0,0)));


#initial workplane generation                                                       ---           ****** Casing Generation ******
perimeter = cq.Workplane("XY");

# Generate plane containing wire-loop                                               ---                     WIRE LOOP
for point in points_list:
    perimeter = perimeter.polarLine(point[0],point[1])
perimeter.close();

# shrink the wire-loop to handle tolerance and wall box_wall_thickness
casing_edge = perimeter.edges().offset2D(-(fit_tolerance_bike + box_wall_thickness))
# Extrude edge to make casing shape                                                 ---                     Casing Geometary Extrude
casing_geometry = casing_edge.extrude(box_total_width);
# fillet edges to make for nice-curved ends
casing_geometry = casing_geometry.edges("|Z").fillet(box_corner_fillet);
# Shell the casing to make the inside hollow.                                       ---                     Shell Casing
casing_geometry = casing_geometry.shell(box_wall_thickness,"arc");

# In the bottom box, add the screw-posts                                            ---                     Bottom casing Post placement
casing_geometry = casing_geometry.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_post_diam/2).extrude(-box_total_width);

# Position a workplane above the edges that need cutting                            ---                     Casing Cable Cut
casing_cable_cut = cq.Workplane("YZ").transformed(
    offset=Cable_hole_position,
    rotate=cq.Vector(0, Cable_hole_angle,0));
# Create a cylinder to represent the material to be removed by the cut.
casing_cable_cut = casing_cable_cut.circle(Cable_hole_diam/2).extrude(-50)
if DEBUG_MODE : debug(casing_cable_cut, name='cable-hole cut volume');
# Subtract the resulting geometary.
casing_geometry = casing_geometry.cut(casing_cable_cut);

# In the top plate, cut holes for the screws to enter the casing through.           ---                     screw hole cutting
casing_geometry =  casing_geometry.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_thread_diam/2).cutBlind(-screw_depth + box_wall_thickness);
# In the top plate, sink holes for the screw-heads to be recessed slighty.
casing_geometry =  casing_geometry.faces(">Z").workplane().pushPoints(screw_placement_points).circle(screw_cap_diam/2).cutBlind(-screw_cap_height);

#   Cut casing Text from the case parts                                             ---                     Cut casing text
casing_geometry = casing_geometry.cut(text_cut_volume);

# Split the casing into two parts                                                   ---                     Seperate left and right halves of the casing
casing_geometry_Left = casing_geometry.intersect(Cut_Volume)
casing_geometry_Right = casing_geometry.intersect(Inverse_Cut_Volume)

# Split casing_geometry into top and bottom parts, this will result in four total parts.
# (top being the thin lid, bottom being the box-casing itself)                      ---                     Casing Split
casing_top_Left = casing_geometry_Left.faces(">Z").workplane(-(box_wall_thickness+lid_casing_split_distance)).split(keepTop=True)
casing_bottom_Left = casing_geometry_Left.faces(">Z").workplane(-(box_wall_thickness+lid_casing_split_distance)).split(keepTop=False,keepBottom=True);
casing_top_Right = casing_geometry_Right.faces(">Z").workplane(-(box_wall_thickness+lid_casing_split_distance)).split(keepTop=True)
casing_bottom_Right = casing_geometry_Right.faces(">Z").workplane(-(box_wall_thickness+lid_casing_split_distance)).split(keepTop=False,keepBottom=True);

## Render resulting geometary                                                       ---                 Render Results
show_object(casing_top_Left, name='casing_lid_left', options=dict(color='#5555ee'));
show_object(casing_top_Right, name='casing_lid_right', options=dict(color='#ee5555'));
show_object(casing_bottom_Right, name='casing_right', options=dict(color='#3333cc'));
show_object(casing_bottom_Left, name='casing_left', options=dict(color='#cc3333'));

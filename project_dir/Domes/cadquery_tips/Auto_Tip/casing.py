# Mike-Bike battery-box casing, by the Astral_3D Team aboard the Astral Ship, 2021-05-15
# Expecting CQ-Editor 0.2.0 or heigher, Cadquery 2.0.0
# This is version 3.0 of the battery-box design, a third prototype based heavily
# on the amazing work of our team!

import cadquery as cq
from cadquery import exporters
from cadquery import importers

DEBUG_MODE = True;


## --------------------------- variables
Track_Height = 18
Track_Width = 45
Track_Steel_Width = 2;

Tip_Length = 100;
Tip_Width_Extra = 10;

Tip_Angle_One = 12;
Tip_Angle_Two = 28.4;

# --------------------------------- precalulated

Tip_Width = Track_Width + Tip_Width_Extra;

## --------------------------- code

Track = cq.Workplane("XY").box(Tip_Length- Tip_Length/5, Track_Width, Track_Height)\
    .faces("-Z or -X or +X").shell(Track_Steel_Width);

# if DEBUG_MODE == True: debug(Track, name='Track');
Tip_Block = cq.Workplane("XY").center(Tip_Length/5, 0)\
    .box(Tip_Length, Tip_Width, Track_Height);

Tip_Cut_One = cq.Workplane("XY").workplane(Track_Height/2).center(0, 0)\
    .moveTo(Tip_Width, Track_Height)\
    .lineTo(Tip_Width, - Track_Height) .lineTo(0, - Track_Height)\
    .lineTo(0, Track_Height) .close()
if DEBUG_MODE == True: debug(Tip_Cut_One, name='Line Art');



Auto_Tip = Tip_Block.cut(Track);
show_object(Auto_Tip, name='casing_left', options=dict(color='#cc3333'));

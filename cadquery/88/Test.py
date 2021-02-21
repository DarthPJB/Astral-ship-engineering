import cadquery as cq

# These can be modified rather than hardcoding values for each dimension.
length = 80.0  # Length of the block
height = 60.0  # Height of the block
thickness = 10.0  # Thickness of the block

# Create a 3D block based on the dimension variables above.
# 1.  Establishes a workplane that an object can be built on.
# 1a. Uses the X and Y origins to define the workplane, meaning that the
# positive Z direction is "up", and the negative Z direction is "down".
result0 = (cq.Workplane("XY")
           .moveTo(10,0)
           .lineTo(5,0)
           .threePointArc((3.9393,0.4393),(3.5,1.5))
           .threePointArc((3.0607,2.5607),(2,3))
           .lineTo(1.5,3)
           .threePointArc((0.4393,3.4393),(0,4.5))
           .lineTo(0,13.5)
           .threePointArc((0.4393,14.5607),(1.5,15))
           .lineTo(28,15)
           .lineTo(28,13.5)
           .lineTo(24,13.5)
           .lineTo(24,11.5)
           .lineTo(27,11.5)
           .lineTo(27,10)
           .lineTo(22,10)
           .lineTo(22,13.2)
           .lineTo(14.5,13.2)
           .lineTo(14.5,10)
           .lineTo(12.5,10 )
           .lineTo(12.5,13.2)
           .lineTo(5.5,13.2)
           .lineTo(5.5,2)
           .threePointArc((5.793,1.293),(6.5,1))
           .lineTo(10,1)
           .close())
result = result0.extrude(100)

result = result.rotate((0, 0, 0),(1, 0, 0), 90)

result = result.translate(result.val().BoundingBox().center.multiply(-1))

mirXY_neg = result.mirror(mirrorPlane="XY", basePointVector=(0, 0, -30))
mirXY_pos = result.mirror(mirrorPlane="XY", basePointVector=(0, 0, 30))
mirZY_neg = result.mirror(mirrorPlane="ZY", basePointVector=(-30, 0, 0))
mirZY_pos = result.mirror(mirrorPlane="ZY", basePointVector=(30, 0, 0))

result = result.union(mirXY_neg).union(mirXY_pos).union(mirZY_neg).union(mirZY_pos)

# The following method is now outdated, but can still be used to display the
# results of the script if you want
# from Helpers import show
# show(result)  # Render the result of this script

with open('88/Test.stl', 'w') as f:
    f.write(cq.exporters.toString(result, 'STL', 10))
f.close();

#show_object(result)

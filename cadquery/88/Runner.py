import cadquery as cq


result = cq.Workplane("XZ").box(10,10,10);
result = result.cut(cq.Workplane("XZ").box(5,5,5));
selector = result.faces().vertices()
rim = cq.Workplane("XZ");
for Vert in range(selector.size()):
    rim = rim.union(selector.item(Vert).circle(0.5).extrude(0.5))

result = result.union(rim);
# The following method is now outdated, but can still be used to display the
# results of the script if you want
# from Helpers import show
show_object(result);  # Render the result of this script

#result.exportSvg( "./88/Runner.svg");
#with open("./88/Runner.stl", 'w') as f:
   #f.write(cq.exporters.toString(result, 'STL', 10))
#f.close();

#show_object(result)

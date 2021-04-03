import os as os
import sys as sys

# appending <current directory>/lib/ to python system path
#   This allows for importing local files outside of current WD
# sys.path.append(os.getcwd() + "/lib/");

# Load CQGI
import cadquery.cqgi as cqgi
import cadquery as cq

model = cqgi.parse(open(os.getcwd() + "/88_assembly/casing.py").read());
build_result = model.build();
if build_result.success:
    count = 0;
    for result in build_result.results:
        print(dir(result.shape))
        with open('88_assembly/output/casing'+ str(count) + '.stl', 'w') as f:
            f.write(cq.exporters.toString(result.shape, 'STL', 10))
        f.close();
        count = count + 1;
else:
    print( "BUILD FAILED: " + str(build_result.exception) + "\n");

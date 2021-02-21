import os as os
import sys as sys

# appending <current directory>/lib/ to python system path
#   This allows for importing local files outside of current WD
sys.path.append(os.getcwd() + "/lib/");

# Load CQGI
import cadquery.cqgi as cqgi

model = cqgi.parse(open(os.getcwd() + "/88/Runner.py").read());
result = model.build();

#exec(open("88/Runner.py").read())

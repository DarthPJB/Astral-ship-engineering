# Engineering/project_dir/mikebike

# MIKE'S BIKE PROJECT =)
This folder contains the working archives of the project undertaken.

## Intention
To allow for rapid assembly the design will be produced using multiple CAD software.

Blender, openSCAD, cadquery/python, solvespace, and others as needed.

Design files will be stored alongside the STL produced from that design.

eg:
    /blender/test.blender
    /blender/test.stl

The STL files may then be copied as needed to the *assembly or composite* folders.

eg:
  /assembly/test.stl
  /composite/test.stl

## cadquery and automation
Due to the complexity of CAD, 88/@DarthPJB will be prototyping automated cad-generation workflows for combining methodologies.

In simple terms, automating the process by which design files are turned into stl files.

Blender, solvespace, and openSCAD will all allow for CLI integration; the ability to command them from linux terminal commands.

the shell.nix file in this folder will be configured such that when run on any NixOS/Nix machine, the latest version of the design will be built from source files upwards; including visualisaion of the design.

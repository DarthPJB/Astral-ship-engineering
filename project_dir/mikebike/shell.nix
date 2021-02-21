#Generate a nix-shell for compiling cadquery, editing source
# and viewing results

#default nixpkgs
{ pkgs ? import <nixpkgs> {} }:

# Generate Shell
pkgs.mkShell
{
  buildInputs = [
  #Python37 and cadquery python37Packages; this provides basic ability
  # to use python CadQueryModel.py to generate output.
  pkgs.python37
  pkgs.python37Packages.cadquery
  #CQ-editor for native rendering of CadQuery Models
  pkgs.cq-editor
  # FastSTL viewer to view resulting STL files
  pkgs.fstl
  # Inkscape for the inkview package (fast SVG viewer)
  pkgs.inkscape
  # atom and vim for effective code editing
  pkgs.atom pkgs.vim
  ];
  #Run build-task post generation (TODO: makefile)
  shellHook = ''
     ./task.sh;
  '';
}

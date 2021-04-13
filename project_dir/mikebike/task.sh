python ./88_assembly/full_model_generation.py
if (( $? ))
  then figlet "FAILED" ;
else fstl ./88_assembly/output/casing0.stl;
fi

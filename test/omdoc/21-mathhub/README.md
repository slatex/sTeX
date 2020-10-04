We employ a trick for testing here:
As \importmhmodule and friends look for a `source` subdirectory, we make a symbolic link `source --> ../modules`, where they can be found.
This seems to work fine for the moment.  

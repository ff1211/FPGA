#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# add_files.tcl
# 
# Description:
# Tcl script to add files to vivado project.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  ff          Initial version
#****************************************************************

# Add source files to Vivado project.
#****************************************************************

# Common modules.
add_files                           \
    $COMMON_DIR/sync_fifo.sv        \
    $COMMON_DIR/single_ram.sv       \
    $COMMON_DIR/tdual_ram.sv        \
    $COMMON_DIR/axi_if.sv           \
    $COMMON_DIR/axil_dummy.sv       
#****************************************************************
# Add library files to Vivado project.
add_files                           \
    $COMMON_DIR/interconnect.vh 
# Add constrain files to Vivado project.
# add_files -fileset constrs_1 ./path/to/constraint/constraint.xdc
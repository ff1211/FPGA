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
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************
# Add source files to Vivado project.
#****************************************************************

# Common modules.
add_files                           \
    $COMMON_DIR/fifo_sync.sv        \
    $COMMON_DIR/ram_single.sv       \
    $COMMON_DIR/ram_tdual.sv        \
    $INTERFACE_DIR/axi_if.sv        
#****************************************************************
# Add library files to Vivado project.
add_files                           \
    $INTERFACE_DIR/interconnect.vh 
# Add constrain files to Vivado project.
# add_files -fileset constrs_1 ./path/to/constraint/constraint.xdc
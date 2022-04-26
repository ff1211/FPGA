#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# sys_reset.sh
# 
# Description:
# Bash shell for add processing system reset ip.
# Sourced by add_ip.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.21  fanfei      Initial version
#****************************************************************

# Add processing system reset.
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0"
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1"

i=0
while [[ $i -ne ${#clk_freq[@]} ]]; do
    add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_${i}"
    i=$((i+1))
done

add_tcl "set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells xlconstant_0]"
add_tcl "set_property -dict [list CONFIG.CONST_VAL {1}] [get_bd_cells xlconstant_1]"

# Assign clock and constant to reset ip.
i=0
while [[ $i -ne ${#clk_freq[@]} ]]; do
    j=$((i+1))
    add_tcl "connect_bd_net [get_bd_pins clk_wiz_0/clk_out$j] [get_bd_pins proc_sys_reset_${i}/slowest_sync_clk]"
    add_tcl "connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_${i}/dcm_locked]"
    add_tcl "connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins proc_sys_reset_${i}/mb_debug_sys_rst]"
    add_tcl "connect_bd_net [get_bd_pins xlconstant_1/dout] [get_bd_pins proc_sys_reset_${i}/aux_reset_in]"
    add_tcl "make_bd_pins_external  [get_bd_pins proc_sys_reset_${i}/interconnect_aresetn]"
    add_tcl "make_bd_pins_external  [get_bd_pins proc_sys_reset_${i}/peripheral_aresetn]"
    i=$((i+1))
done




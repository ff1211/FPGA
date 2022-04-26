#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# clock_wizard.sh
# 
# Description:
# Bash shell for add clock wizard ip
# Sourced by add_ip.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.21  fanfei      Initial version
#****************************************************************

# Add ip.
#****************************************************************
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0"
add_tcl "set_property -dict [list CONFIG.USE_LOCKED {true} CONFIG.USE_RESET {false}] [get_bd_cells clk_wiz_0]"
clk_port_en=""

i=0
while [[ $i -ne ${#clk_freq[@]} ]]; do
    clk_port_en="$clk_port_en CONFIG.CLKOUT$((i+1))_USED {true}"
    add_define "USE_CLK_$i"
    i=$((i+1))
done
add_tcl "set_property -dict [list $clk_port_en] [get_bd_cells clk_wiz_0]"

j=1
for clk in ${clk_freq[@]}; do
    add_tcl "set_property -dict [list CONFIG.CLKOUT${j}_REQUESTED_OUT_FREQ {${clk}}] [get_bd_cells clk_wiz_0]"
    add_tcl "make_bd_pins_external  [get_bd_pins clk_wiz_0/clk_out$j]"
    add_tcl "set_property name clk_out$j [get_bd_ports clk_out${j}_0]"
    j=$((j+1))
done

add_define "SYS_CLK_NUM" ${#clk_freq[@]}
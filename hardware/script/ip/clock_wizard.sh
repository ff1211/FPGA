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
# 1.0      2022.04.21  Fanfei      Initial version
#****************************************************************

# Add ip.
#****************************************************************
echo "create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clk_wiz_0" >> "$add_ip_tcl_path"
clk_port_en=""

i=1
while [[ i -le ${#clk_freq[@]} ]]; do
    clk_port_en="$clk_port_en CONFIG.CLKOUT${i}_USED {true}"
    i=$((i+1))
done
echo "set_property -dict [list $clk_port_en] [get_ips clk_wiz_0]" >> "$add_ip_tcl_path"

# Add define to pre_proc.vh.
#****************************************************************
j=1
while [[ j -le $i ]]; do
    add_ip_define "USE_CLK_$j"
    j=$((j+1))
done
add_ip_define "SYS_CLK_NUM" "$i"

# Add hdl wrapper file.
add_ip_wrapper "$SHELL_DIR/common/sys_clock.sv"
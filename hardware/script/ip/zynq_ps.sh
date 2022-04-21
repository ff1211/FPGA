#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# zynqs_ps.sh
# 
# Description:
# Bash shell for add Zynq processing system ip.
# Sourced by add_ip.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.20  Fanfei      Initial version
#****************************************************************

# Add processing system reset.
echo "create_ip -name proc_sys_reset -vendor xilinx.com -library ip -version 5.0 -module_name proc_sys_reset_0" >> $add_ip_tcl_path

# Add processing system hardcore.
if [[ $platform == "zynq-7000" ]];  then
    echo "create_ip -name processing_system7 -vendor xilinx.com -library ip -version 5.5 -module_name processing_system7_0" >> $add_ip_tcl_path
    echo "set_property -dict [list CONFIG.preset {$board_name}] [get_ips processing_system7_0]" >> $add_ip_tcl_path
    # Add hdl wrapper file.
    add_ip_wrapper "$SHELL_DIR/zynq_ps/ps_7.sv"
elif [[ $platform == "ultrascale" ]]; then
    echo "Haven't support Zynq-UltraScale now."
fi
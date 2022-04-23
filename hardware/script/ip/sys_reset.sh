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
echo "create_ip -name proc_sys_reset -vendor xilinx.com -library ip -version 5.0 -module_name proc_sys_reset_0" >> $add_ip_tcl_path

# Add hdl wrapper file.
add_ip_wrapper "$SHELL_DIR/common/sys_reset.sv"
#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# add_ip.sh
# 
# Description:
# Bash shell for generate add_ip.tcl.
# Sourced by project.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************

# Gloable varibles and functions.
#****************************************************************
export ip_wrapper_files=""

# Function to add ip define to pre_proc.vh
# 1st parameter: Define name.
# 2st parameter: Define value.
# Example: add_ip_define "USE_AXI_GP"
# Example: add_ip_define "M_AXI_GP_PORT_NUM" 1
add_ip_define(){
    define="\`define $1"
    if [[ $2 != "" ]]; then 
        define="$define = $2"
    fi
    echo "$define" >> "$pre_proc_path"
}

# Function to add ip wrappers's path to ip_wrapper_files.
# 1st parameter: Ip wrappers's path.
add_ip_wrapper(){
    ip_wrapper_files="$ip_wrapper_files $1"
}

# Zynq processing system config.
#****************************************************************
# Zynq AXI general purpose slave port config.
export axi_gp_port_num=0            # AXI general purpose slave port number, range[0, 2].
# Zynq AXI high performance slave port config.
export axi_hp_port_num=0            # AXI high performance slave port number, range[0, 4].
export axi_hp_port_dw=(32 32 32 32) # AXI high performance slave port data width, 32 or 64.

# Add Zynq processing system.
source $SCRIPT_DIR/ip/zynq_ps.sh

# Add clock wizard.
source $SCRIPT_DIR/ip/clock_wizard.sh

# Add AXI DMA.
[[ $use_axi_dma -eq 1 ]] && source $SCRIPT_DIR/ip/axi_dma.sh

# Add AXI VDMA.

# Add IP wrapper files.
[[ $ip_wrapper_files != "" ]] && echo "add_files $ip_wrapper_files" >> $add_ip_tcl_path

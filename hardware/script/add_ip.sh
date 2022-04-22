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
        define="$define $2"
    fi
    echo "$define" >> "$pre_proc_path"
}

# Function to add ip wrappers's path to ip_wrapper_files.
# 1st parameter: Ip wrappers's path.
add_ip_wrapper(){
    ip_wrapper_files="$ip_wrapper_files $1"
}

# Zynq processing system AXI port config.
#****************************************************************
# Zynq AXI general purpose slave port config.
export m_axi_gp_num=1     # AXI general purpose master port number, range[0, 2].
# Zynq AXI general purpose slave port config.
export s_axi_gp_num=0     # AXI general purpose slave port number, range[0, 2].
# Zynq AXI high performance slave port config.
export s_axi_hp_num=0     # AXI high performance slave port number, range[0, 4].
export s_axi_hp_dw=64     # AXI high performance slave port data width, 32 or 64.

# axi lite port zynq mastered.
export m_axil_num=0

# Add clock wizard.
source $SCRIPT_DIR/ip/clock_wizard.sh

# Add processing system reset.
source $SCRIPT_DIR/ip/sys_reset.sh

# Add AXI DMA.
[[ $use_axi_dma -eq 1 ]] && source $SCRIPT_DIR/ip/axi_dma.sh

# Add Video DMA.

# Add Zynq processing system.
source $SCRIPT_DIR/ip/zynq_ps.sh

# Add axi interconnect.
[[ m_axil_num -ne 0 ]] && source $SCRIPT_DIR/ip/axi_int.sh

# Add defines and files.
#****************************************************************
# If use axi general purpose master port.
if [[ $m_axi_gp_num -ne 0 ]]; then
    add_ip_define "USE_M_AXI_GP"
    add_ip_define "M_AXI_GP_NUM" $m_axi_gp_num
    i=0
    while [[ i -ne $m_axi_gp_num ]]; do
        add_ip_define "USE_M_AXI_GP_${i}"
        i=$((i+1))
    done
fi

# If use axi general purpose slave port.
if [[ $s_axi_gp_num -ne 0 ]]; then
    add_ip_define "USE_S_AXI_GP"
    add_ip_define "S_AXI_GP_NUM" $s_axi_gp_num
    i=0
    while [[ i -ne $s_axi_gp_num ]]; do
        add_ip_define "USE_S_AXI_GP_${i}"
        i=$((i+1))
    done
fi

# If use axi high performance slave port.
if [[ $s_axi_hp_num -ne 0 ]]; then
    add_ip_define "USE_S_AXI_HP"
    add_ip_define "S_AXI_HP_NUM" $s_axi_hp_num
    add_ip_define "S_AXI_HP_DW" $s_axi_hp_dw
    i=0
    while [[ i -ne $s_axi_hp_num ]]; do
        add_ip_define "USE_S_AXI_HP_${i}"
        i=$((i+1))
    done
fi

# If use axi lite port.
if [[ $m_axil_num -ne 0 ]]; then
    add_ip_define "USE_M_AXIL"
    add_ip_define "M_AXIL_NUM" $m_axil_num
    i=0
    while [[ i -ne $m_axil_num ]]; do
        add_ip_define "USE_AXIL_${i}"
        i=$((i+1))
    done
fi

echo "\`endif" >> "$pre_proc_path"

# Add IP wrapper files.
[[ $ip_wrapper_files != "" ]] && echo "add_files $ip_wrapper_files" >> $add_ip_tcl_path
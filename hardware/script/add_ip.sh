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
# 1.0      2022.04.14  ff          Initial version
#****************************************************************

# Gloable varibles and functions.
#****************************************************************
export ip_wrapper_files=""

# Function to add ip define to pre_proc.vh
# 1st parameter: Define name.
# 2st parameter: Define value.
# Example: add_define "USE_AXI_GP"
# Example: add_define "M_AXI_GP_PORT_NUM" 1
add_define(){
    define="\`define $1"
    if [[ $2 != "" ]]; then 
        define="$define $2"
    fi
    echo "$define" >> "$pre_proc_path"
}

add_tcl(){
    echo "$1" >> "$add_ip_tcl_path"
}

# Function to add ip wrappers's path to ip_wrapper_files.
# 1st parameter: Ip wrappers's path.
add_ip_wrapper(){
    ip_wrapper_files="$ip_wrapper_files $1"
}

# clock associated busif
export clk0_assoc_busif=""
export clk1_assoc_busif=""
export clk2_assoc_busif=""
export clk3_assoc_busif=""
export clk4_assoc_busif=""
export clk5_assoc_busif=""
export clk6_assoc_busif=""
export clk7_assoc_busif=""

export m_axil_assign=$((1+$m_axil_user_num))
export m_axi_gp_assign=1
export s_axi_gp_assign=0
export s_axi_hp_assign=0
export m_axil_addr_assign=0

# Block design IP
#****************************************************************
echo "create_bd_design \"sys_bd\"" >> "$add_ip_tcl_path"

# Add clock wizard.
source $SCRIPT_DIR/ip/clock_wizard.sh

# Add processing system reset.
source $SCRIPT_DIR/ip/sys_reset.sh

# Add Zynq processing system.
source $SCRIPT_DIR/ip/zynq_ps.sh

# Add AXI DMA.
[[ $use_axi_dma -eq 1 ]] && source $SCRIPT_DIR/ip/axi_dma.sh

# Add Video DMA.

# Save board design.
add_tcl "save_bd_design"
#****************************************************************


# Other IP.
#****************************************************************
# Add pl btn
if [[ $use_pl_btn -eq 1 ]]; then 
    add_define "USE_PL_BTN"
    add_ip_wrapper "$PRESET_DIR/xdc/btn.xdc"
fi
# Add vga
if [[ $use_vga -eq 1 ]]; then
    add_define "USE_VGA" 
    add_ip_wrapper "$PRESET_DIR/xdc/vga.xdc"
fi
# Add pl clk.
if [[ $use_pl_clk -eq 1 ]]; then
    add_define "USE_PL_CLK"
    add_ip_wrapper "$PRESET_DIR/xdc/pl_clk.xdc"
fi
#****************************************************************


# Add defines and files.
#****************************************************************
# If use axi general purpose master port.
if [[ $m_axi_gp_num -ne 0 ]]; then
    add_define "USE_M_AXI_GP"
    add_define "M_AXI_GP_NUM" $m_axi_gp_num
    i=0
    while [[ $i -ne $m_axi_gp_num ]]; do
        add_define "USE_M_AXI_GP_${i}"
        i=$((i+1))
    done
fi

# If use axi general purpose slave port.
if [[ $s_axi_gp_num -ne 0 ]]; then
    add_define "USE_S_AXI_GP"
    add_define "S_AXI_GP_NUM" $s_axi_gp_num
    i=0
    while [[ $i -ne $s_axi_gp_num ]]; do
        add_define "USE_S_AXI_GP_${i}"
        i=$((i+1))
    done
fi

# If use axi high performance slave port.
if [[ $s_axi_hp_num -ne 0 ]]; then
    add_define "USE_S_AXI_HP"
    add_define "S_AXI_HP_NUM" $s_axi_hp_num
    i=0
    while [[ $i -ne $s_axi_hp_num ]]; do
        add_define "USE_S_AXI_HP_${i}"
        i=$((i+1))
    done
fi

# If use axi lite port.
if [[ $m_axil_num -ne 0 ]]; then
    add_define "USE_M_AXIL"
    add_define "M_AXIL_NUM" $m_axil_num
    i=0
    while [[ $i -ne $m_axil_num ]]; do
        add_define "USE_M_AXIL_${i}"
        i=$((i+1))
    done
fi

# If user axi lite port != 0.
if [[ $m_axil_user_num -ne 0 ]]; then
    add_define "USE_M_AXIL_USER"
    add_define "M_AXIL_USER_NUM" $m_axil_user_num
    i=0
    while [[ $i -ne $m_axil_user_num ]]; do
        add_define "USE_M_AXIL_USER_${i}"
        i=$((i+1))
    done
fi

echo "\`endif" >> "$pre_proc_path"

# Add IP wrapper files.
[[ $ip_wrapper_files != "" ]] && add_tcl "add_files $ip_wrapper_files"
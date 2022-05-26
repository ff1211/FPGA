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
# Files to be added to project.
files=""

# Function to add ip define to pre_proc.vh
# 1st parameter: Define name
# 2st parameter: Define value
# Example: add_define "USE_AXI_GP"
# Example: add_define "M_AXI_GP_PORT_NUM" 1
add_define(){
    define="\`define $1"
    if [[ $2 != "" ]]; then 
        define="$define $2"
    fi
    echo "$define" >> "$pre_proc_path"
}

# Function to add tcl command.
# 1st parameter: Tcl command
add_tcl(){
    echo "$1" >> "$add_ip_tcl_path"
}

# Function to add file's path to files.
# 1st parameter: File's path.
add_file(){
    files="$files $1"
}

# Clock associated busif.
clk0_assoc_busif=""
clk1_assoc_busif=""
clk2_assoc_busif=""
clk3_assoc_busif=""
clk4_assoc_busif=""
clk5_assoc_busif=""
clk6_assoc_busif=""
clk7_assoc_busif=""

# Record which axi port has been assigned.
m_axi_gp0_assign=$((1+$m_axil_user_num))
m_axi_gp1_assign=00
s_axi_gp0_assign=00
s_axi_gp1_assign=00
s_axi_hp0_assign=00
s_axi_hp1_assign=00
s_axi_hp2_assign=00
s_axi_hp3_assign=00
m_axi_gp0_addr_assign=0
m_axi_gp1_addr_assign=0

# Set AXI lite port and sg port.
if [[ $platform == "zynq-7000" ]]; then
    declare -n axil_assign_r="s_axi_gp0_assign"
fi

#****************************************************************

# Create block design.
#****************************************************************
echo "create_bd_design \"sys_bd\"" >> "$add_ip_tcl_path"

# Add clock wizard.
source "$SCRIPT_DIR/ip/clock_wizard.sh"

# Add processing system reset.
source "$SCRIPT_DIR/ip/sys_reset.sh"

# Add Zynq processing system.
if [[ $platform == "zynq-7000" ]];  then
    source "$SCRIPT_DIR/ip/zynq_ps/z7.sh"
elif [[ $platform == "zynq-ultrascale" ]]; then
    echo "Error! Haven't support Zynq-UltraScale now!"
    error
    # source "$SCRIPT_DIR/ip/zynq_ps/zu.sh"
fi

# Add AXI DMA.
i=0
while [[ ${use_adma[i]} -eq 1 ]]; do 
    source "$SCRIPT_DIR/ip/adma.sh" $i
    i=$((i+1))
done

# Add Video DMA.
i=0
while [[ ${use_vdma[i]} -eq 1 ]]; do 
    source "$SCRIPT_DIR/ip/vdma.sh" $i
    i=$((i+1))
done

# Automatically assign addresses to unmapped IP.
add_tcl "assign_bd_address"

# Save board design.
add_tcl "save_bd_design"
#****************************************************************

# Other IP.
#****************************************************************
type -t "$PRESET_DIR/other_ip.sh" > /dev/null
if [[ $? -ne 1 ]]; then
    source "$PRESET_DIR/other_ip.sh"
fi

# Add pl clk.
if [[ $use_pl_clk -eq 1 ]]; then
    add_define "USE_PL_CLK"
    add_file "$PRESET_DIR/xdc/pl_clk.xdc"
fi
#****************************************************************

# Add defines and files.
#****************************************************************
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
[[ $files != "" ]] && add_tcl "add_files $files"
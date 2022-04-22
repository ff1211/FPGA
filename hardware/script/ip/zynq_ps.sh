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

# Add processing system hardcore.
if [[ $platform == "zynq-7000" ]];  then
    # Add ip.
    echo "create_ip -name processing_system7 -vendor xilinx.com -library ip -version 5.5 -module_name processing_system7_0" >> $add_ip_tcl_path
    echo "source $BOARDS_DIR/$board_name/ps_preset.tcl" >> $add_ip_tcl_path
    echo "set_property -dict [apply_preset processing_system7_0] [get_ips processing_system7_0]" >> $add_ip_tcl_path

    # Config AXI port.
    i=0
    axi_config_list=""
    while [[ i -ne $m_axi_gp_num ]]; do axi_config_list="$axi_config_list CONFIG.PCW_USE_M_AXI_GP${i} {1}"; i=$((i+1)); done; i=0
    while [[ i -ne $s_axi_gp_num ]]; do axi_config_list="$axi_config_list CONFIG.PCW_USE_S_AXI_GP${i} {1}"; i=$((i+1)); done; i=0
    while [[ i -ne $s_axi_hp_num ]]; do axi_config_list="$axi_config_list CONFIG.PCW_USE_S_AXI_HP${i} {1}"; i=$((i+1)); done; i=0
    echo "set_property -dict [list $axi_config_list] [get_ips processing_system7_0]" >> "$add_ip_tcl_path"
    
    # Add hdl wrapper file.
    add_ip_wrapper "$SHELL_DIR/zynq_ps/ps_7.sv"
elif [[ $platform == "ultrascale" ]]; then
    echo "Haven't support Zynq-UltraScale now."
fi
#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# pre_proc.sh
# 
# Description:
# Bash script to generate config.vh
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************

# If use axi general purpose port.
if [[ ${axi_gp_port_num} -ne 0 ]]; then
    echo "\`define USE_AXI_GP_PORT" >> "$pre_proc_path"
    echo "\`define AXI_GP_PORT_NUM = $axi_gp_port_num" >> "$pre_proc_path"
fi
# If use axi high performance port.
if [[ ${axi_hp_port_num} -ne 0 ]]; then
    echo "\`define USE_AXI_HP_PORT" >> "$pre_proc_path"
    echo "\`define AXI_HP_PORT_NUM = $axi_hp_port_num" >> "$pre_proc_path"
    echo "\`define AXI_HP_PORT_DW = $axi_hp_port_dw" >> "$pre_proc_path"
fi
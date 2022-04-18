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

# Generate add_ip.tcl for add ips.
touch $cur_pj_script_dir/add_ip.tcl
add_ip_tcl_path=$cur_pj_script_dir/add_ip.tcl
cat > $cur_pj_script_dir/add_ip.tcl << EOF
#****************************************************************
# This is a auto-generated file. Do not change it!
#****************************************************************
EOF

# Zynq processing system config.
#****************************************************************
# Zynq AXI general purpose slave port config.
export axi_gp_port_num=0            # AXI general purpose slave port number, range[0, 2].
# Zynq AXI high performance slave port config.
export axi_hp_port_num=0            # AXI high performance slave port number, range[0, 4].
export axi_hp_port_dw=(32 32 32 32) # AXI high performance slave port data width, 32 or 64.
i=0
define_synx="\`define"

export ip_wrapper_files=""

# Add AXI DMA.
[[ $use_axi_dma -ne 0 ]] && source "$SCRIPT_DIR/ip/axi_dma.sh"

# Add IP wrapper files.
[[ ip_wrapper_files != "" ]] && echo "add_files $ip_wrapper_files" >> $add_ip_tcl_path

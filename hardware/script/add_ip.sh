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
i=0
touch $cur_project_dir/add_ip.tcl
cat > $cur_project_dir/add_ip.tcl << EOF
//****************************************************************
// This is a auto-generated file. Do not change it!
//****************************************************************
EOF

# Add dma.
while [[ i -ne $axi_dma_num ]]; do
    echo "create_ip -name axi_dma -vendor xilinx.com -library ip -version 7.1 -module_name axi_dma_$i" >> add_ip.tcl
    if [[ ${axi_dma_mode[i]} -eq "block" ]]; then
        echo "set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_include_stscntrl_strm {0}] [get_ips axi_dma_$i]" >> add_ip.tcl
    else
        echo "Error! We haven't support sg mode now!"
        exit 1
    fi
    if [[ ${axi_dma_s_dw[i]} -gt ${axi_dma_mm_dw[i]} ]]; then
        echo "Error! AXI DMA axi-stream data width must less or equal than memory map data width!"
        exit 1
    else
        # Disable channels according to config.
        mm2s=1
        s2mm=1
        [[ ${axi_dma_dir[i]} -eq "write" ]] && mm2s=0
        [[ ${axi_dma_dir[i]} -eq "read" ]] && s2mm=0
        echo "set_property -dict [list CONFIG.c_include_mm2s {$mm2s} CONFIG.c_include_s2mm {$s2mm}] [get_ips axi_dma_$i]" >> add_ip.tcl
        # Set channel's data and address width and burst width.
        mm2s_burst_size=2
        s2mm_burst_size=2
        [[ ${axi_dma_mm_dw[i]} -lt 256 ]] && mm2s=`expr 512 / ${axi_dma_mm_dw[i]}`
        [[ ${axi_dma_mm_dw[i]} -lt 256 ]] && s2mm=`expr 512 / ${axi_dma_mm_dw[i]}`
        echo "set_property -dict [list CONFIG.c_m_axi_mm2s_data_width {${axi_dma_mm_dw[i]}} CONFIG.c_m_axis_mm2s_tdata_width {${axi_dma_s_dw[i]}} CONFIG.c_mm2s_burst_size {$mm2s_burst_size}] [get_ips axi_dma_$i]" >> add_ip.tcl
        echo "set_property -dict [list CONFIG.c_m_axi_s2mm_data_width {${axi_dma_mm_dw[i]}} CONFIG.c_s_axis_s2mm_tdata_width {${axi_dma_s_dw[i]}} CONFIG.c_s2mm_burst_size {$s2mm_burst_size}] [get_ips axi_dma_$i]" >> add_ip.tcl
    fixw
done
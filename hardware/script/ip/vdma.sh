#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# vdma.sh
# 
# Description:
# Bash shell for add Video DMA ip.
# Sourced by add_ip.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.05.03  ff          Initial version
#****************************************************************

# Add ip
#****************************************************************
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_0"
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_vdma"

# Disable channels according to config.
mm2s=1
s2mm=1
[[ ${vdma_dir} == "write" ]] && mm2s=0
[[ ${vdma_dir} == "read" ]] && s2mm=0
add_tcl "set_property -dict [list CONFIG.c_include_mm2s {$mm2s} CONFIG.c_include_s2mm {$s2mm}] [get_bd_cells vdma_0]"
add_tcl "set_property -dict [list CONFIG.NUM_SI {$((mm2s+s2mm))} CONFIG.NUM_MI {1}] [get_bd_cells axi_interconnect_vdma]"

# Set channel's data and address width and burst width.
mm2s_burst_size=2
s2mm_burst_size=2
if [[ $mm2s -eq 1 ]]; then
    [[ ${vdma_mm_dw} -lt 256 ]] && mm2s_burst_size=$((512 / ${vdma_mm_dw}))
    add_tcl "set_property -dict [list CONFIG.c_m_axi_mm2s_data_width {${vdma_mm_dw}} CONFIG.c_m_axis_mm2s_tdata_width {${vdma_s_dw}} CONFIG.c_mm2s_burst_size {$mm2s_burst_size}] [get_bd_cells vdma_0]"
    
    add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins vdma_0/M_AXIS_MM2S]"
    add_tcl "set_property name M_AXIS_VDMA_MM2S [get_bd_intf_ports M_AXIS_MM2S_0]"
    export clk1_assoc_busif="M_AXIS_VDMA_MM2S"
fi
if [[ $s2mm -eq 1 ]]; then
    [[ ${vdma_mm_dw} -lt 256 ]] && s2mm_burst_size=$((512 / ${vdma_mm_dw}))
    add_tcl "set_property -dict [list CONFIG.c_m_axi_s2mm_data_width {${vdma_mm_dw}} CONFIG.c_s_axis_s2mm_tdata_width {${vdma_s_dw}} CONFIG.c_s2mm_burst_size {$s2mm_burst_size}] [get_bd_cells vdma_0]"
    
    add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins vdma_0/S_AXIS_S2MM]"
    add_tcl "set_property name S_AXIS_VDMA_S2MM [get_bd_intf_ports S_AXIS_S2MM_0]"
    export clk1_assoc_busif="${clk1_assoc_busif}:S_AXIS_VDMA_S2MM"
fi
add_tcl "set_property CONFIG.ASSOCIATED_BUSIF {$clk1_assoc_busif} [get_bd_ports /clk_out2]"
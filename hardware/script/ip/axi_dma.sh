#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# axi_dma.sh
# 
# Description:
# Bash shell for add AXI DMA ip.
# Sourced by add_ip.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  fanfei      Initial version
#****************************************************************

# Add ip
#****************************************************************
echo "create_ip -name axi_dma -vendor xilinx.com -library ip -version 7.1 -module_name axi_dma_0" >> "$add_ip_tcl_path"
if [[ ${axi_dma_mode} == "block" ]]; then
    echo "set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_include_stscntrl_strm {0}] [get_ips axi_dma_0]" >> "$add_ip_tcl_path"
else
    echo "Error! We haven't support sg mode now!"
    error
fi

# Disable channels according to config.
mm2s=1
s2mm=1
[[ ${axi_dma_dir} == "write" ]] && mm2s=0
[[ ${axi_dma_dir} == "read" ]] && s2mm=0
echo "set_property -dict [list CONFIG.c_include_mm2s {$mm2s} CONFIG.c_include_s2mm {$s2mm}] [get_ips axi_dma_0]" >> "$add_ip_tcl_path"
# Set channel's data and address width and burst width.
mm2s_burst_size=2
s2mm_burst_size=2
if [[ mm2s -eq 1 ]]; then
    [[ ${axi_dma_mm_dw} -lt 256 ]] && mm2s_burst_size=$((512 / ${axi_dma_mm_dw}))
    echo "set_property -dict [list CONFIG.c_m_axi_mm2s_data_width {${axi_dma_mm_dw}} CONFIG.c_m_axis_mm2s_tdata_width {${axi_dma_s_dw}} CONFIG.c_mm2s_burst_size {$mm2s_burst_size}] [get_ips axi_dma_0]" >> "$add_ip_tcl_path"
fi
if [[ s2mm -eq 1 ]]; then
    [[ ${axi_dma_mm_dw} -lt 256 ]] && s2mm_burst_size=$((512 / ${axi_dma_mm_dw}))
    echo "set_property -dict [list CONFIG.c_m_axi_s2mm_data_width {${axi_dma_mm_dw}} CONFIG.c_s_axis_s2mm_tdata_width {${axi_dma_s_dw}} CONFIG.c_s2mm_burst_size {$s2mm_burst_size}] [get_ips axi_dma_0]" >> "$add_ip_tcl_path"
fi

# Add define to pre_proc.vh.
#****************************************************************
add_ip_define "USE_AXI_DMA"
if [[ ${axi_dma_dir} == "write" ]]; then
    add_ip_define "USE_AXI_DMA_WRITE"
elif [[ ${axi_dma_dir} == "read" ]]; then
    add_ip_define "USE_AXI_DMA_READ"
else
    add_ip_define "USE_AXI_DMA_WRITE"    
    add_ip_define "USE_AXI_DMA_READ"
fi
add_ip_define "AXI_DMA_AW" "$axi_dma_aw"
add_ip_define "AXI_DMA_MM_DW" "$axi_dma_mm_dw"
add_ip_define "AXI_DMA_S_DW" "$axi_dma_s_dw"
export s_axi_hp_num=$((s_axi_hp_num + 1))
export m_axil_num=$((m_axil_num + 1))

# Add hdl wrapper file.
#****************************************************************
add_ip_wrapper "$SHELL_DIR/axi_dma/axi_dma.sv"
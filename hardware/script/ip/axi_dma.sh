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
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0"
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_adma"

if [[ ${axi_dma_mode} == "block" ]]; then
    add_tcl "set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_include_stscntrl_strm {0}] [get_bd_cells axi_dma_0]"
else
    echo "Error! We haven't support sg mode now!"
    error
fi

# Disable channels according to config.
mm2s=1
s2mm=1
[[ ${axi_dma_dir} == "write" ]] && mm2s=0
[[ ${axi_dma_dir} == "read" ]] && s2mm=0
add_tcl "set_property -dict [list CONFIG.c_include_mm2s {$mm2s} CONFIG.c_include_s2mm {$s2mm}] [get_bd_cells axi_dma_0]"
add_tcl "set_property -dict [list CONFIG.NUM_SI {$((mm2s+s2mm))} CONFIG.NUM_MI {1}] [get_bd_cells axi_interconnect_adma]"

# Set channel's data and address width and burst width.
mm2s_burst_size=2
s2mm_burst_size=2
if [[ $mm2s -eq 1 ]]; then
    [[ ${axi_dma_mm_dw} -lt 256 ]] && mm2s_burst_size=$((512 / ${axi_dma_mm_dw}))
    add_tcl "set_property -dict [list CONFIG.c_m_axi_mm2s_data_width {${axi_dma_mm_dw}} CONFIG.c_m_axis_mm2s_tdata_width {${axi_dma_s_dw}} CONFIG.c_mm2s_burst_size {$mm2s_burst_size}] [get_bd_cells axi_dma_0]"
    
    add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S]"
    add_tcl "set_property name M_AXIS_ADMA_MM2S [get_bd_intf_ports M_AXIS_MM2S_0]"
    export clk1_assoc_busif="M_AXIS_ADMA_MM2S"
fi
if [[ $s2mm -eq 1 ]]; then
    [[ ${axi_dma_mm_dw} -lt 256 ]] && s2mm_burst_size=$((512 / ${axi_dma_mm_dw}))
    add_tcl "set_property -dict [list CONFIG.c_m_axi_s2mm_data_width {${axi_dma_mm_dw}} CONFIG.c_s_axis_s2mm_tdata_width {${axi_dma_s_dw}} CONFIG.c_s2mm_burst_size {$s2mm_burst_size}] [get_bd_cells axi_dma_0]"
    
    add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]"
    add_tcl "set_property name S_AXIS_ADMA_S2MM [get_bd_intf_ports S_AXIS_S2MM_0]"
    export clk1_assoc_busif="${clk1_assoc_busif}:S_AXIS_ADMA_S2MM"
fi
add_tcl "set_property CONFIG.ASSOCIATED_BUSIF {$clk1_assoc_busif} [get_bd_ports /clk_out2]"

# Assign memory-map channel to interconnect and zynq
if [[ ${axi_dma_dir} == "read" ]]; then
    add_tcl "connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] -boundary_type upper [get_bd_intf_pins axi_interconnect_adma/S00_AXI]"
    add_tcl "connect_bd_net [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins clk_wiz_0/clk_out2]"
elif [[ ${axi_dma_dir} == "write" ]]; then
    add_tcl "connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] -boundary_type upper [get_bd_intf_pins axi_interconnect_adma/S00_AXI]"
    add_tcl "connect_bd_net [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins clk_wiz_0/clk_out2]"
else
    add_tcl "connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] -boundary_type upper [get_bd_intf_pins axi_interconnect_adma/S00_AXI]"
    add_tcl "connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] -boundary_type upper [get_bd_intf_pins axi_interconnect_adma/S01_AXI]"
    add_tcl "connect_bd_net [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins clk_wiz_0/clk_out2]"
    add_tcl "connect_bd_net [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins clk_wiz_0/clk_out2]"
fi
add_tcl "connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_interconnect_adma/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP${s_axi_hp_assign}]"
export s_axi_hp_assign=$((s_axi_hp_assign+1))

# Assign axi interconnect's clock and reset.
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_adma/ACLK] [get_bd_pins clk_wiz_0/clk_out2]"
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_adma/ARESETN] [get_bd_pins proc_sys_reset_1/interconnect_aresetn]"
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_adma/M00_ACLK] [get_bd_pins clk_wiz_0/clk_out2]"
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_adma/M00_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]"
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_adma/S00_ACLK] [get_bd_pins clk_wiz_0/clk_out2]"
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_adma/S00_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]"

if [[ ${axi_dma_dir} == "dual" ]]; then
    add_tcl "connect_bd_net [get_bd_pins axi_interconnect_adma/S01_ACLK] [get_bd_pins clk_wiz_0/clk_out2]"
    add_tcl "connect_bd_net [get_bd_pins axi_interconnect_adma/S01_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]"
fi

# Assign axi lite.
add_tcl "connect_bd_intf_net [get_bd_intf_pins axi_dma_0/S_AXI_LITE] -boundary_type upper [get_bd_intf_pins axi_interconnect_axil/M0${m_axil_assign}_AXI]"
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_axil/M0${m_axil_assign}_ACLK] [get_bd_pins clk_wiz_0/clk_out3]"
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_axil/M0${m_axil_assign}_ARESETN] [get_bd_pins proc_sys_reset_2/peripheral_aresetn]"
add_tcl "connect_bd_net [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins clk_wiz_0/clk_out3]"
add_tcl "connect_bd_net [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins proc_sys_reset_2/peripheral_aresetn]"
export m_axil_assign=$((m_axil_assign+1))

# Assign axil lite address space.
add_tcl "assign_bd_address -target_address_space /processing_system7_0/Data [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] -force"
add_tcl "set_property offset 0x4${m_axil_addr_assign}000000 [get_bd_addr_segs {processing_system7_0/Data/SEG_axi_dma_0_Reg}]"
add_tcl "set_property range $axil_addr_range [get_bd_addr_segs {processing_system7_0/Data/SEG_axi_dma_0_Reg}]"
export m_axil_addr_assign=$((m_axil_addr_assign+1))

# Assign axi hp slave address space.
add_tcl "assign_bd_address -target_address_space /axi_dma_0/Data_MM2S [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force"
add_tcl "assign_bd_address -target_address_space /axi_dma_0/Data_S2MM [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force"

# Add define to pre_proc.vh.
#****************************************************************
add_define "USE_AXI_DMA"
if [[ ${axi_dma_dir} == "write" ]]; then
    add_define "USE_AXI_DMA_WRITE"
elif [[ ${axi_dma_dir} == "read" ]]; then
    add_define "USE_AXI_DMA_READ"
else
    add_define "USE_AXI_DMA_WRITE"    
    add_define "USE_AXI_DMA_READ"
fi
add_define "AXI_DMA_AW" "$axi_dma_aw"
add_define "AXI_DMA_MM_DW" "$axi_dma_mm_dw"
add_define "AXI_DMA_S_DW" "$axi_dma_s_dw"
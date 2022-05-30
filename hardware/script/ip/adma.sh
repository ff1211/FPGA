#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# adma.sh
# 
# Description:
# Bash shell for add AXI DMA ip.
# Sourced by add_ip.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  ff          Initial version
#****************************************************************

# Add ip
#****************************************************************
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 adma_$1"
ic="axi_ic_s_${adma_data_port[i]}"

declare -n s_axi_assign_r="s_axi_${adma_data_port[i]}_assign"

if [[ ${adma_mode} == "block" ]]; then
    add_tcl "set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_include_stscntrl_strm {0}] [get_bd_cells adma_$1]"
else
    add_tcl "set_property -dict [list CONFIG.c_include_sg {1} CONFIG.c_sg_include_stscntrl_strm {0}] [get_bd_cells adma_$1]"
    add_tcl "connect_bd_intf_net [get_bd_intf_pins adma_$1/M_AXI_SG] -boundary_type upper [get_bd_intf_pins ${ic}/S${s_axi_assign_r}_AXI]"
    add_tcl "connect_bd_net [get_bd_pins adma_$1/m_axi_sg_aclk] [get_bd_pins clk_wiz_0/clk_out1]"
    add_tcl "connect_bd_net [get_bd_pins ${ic}/S${s_axi_assign_r}_ACLK] [get_bd_pins clk_wiz_0/clk_out1]"
    add_tcl "connect_bd_net [get_bd_pins ${ic}/S${s_axi_assign_r}_ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]"
    add_bus_port "s_axi_assign_r" 1
fi

# Disable channels according to config.
mm2s=1
s2mm=1
[[ ${adma_dir[i]} == "write" ]] && mm2s=0
[[ ${adma_dir[i]} == "read" ]] && s2mm=0
add_tcl "set_property -dict [list CONFIG.c_include_mm2s {$mm2s} CONFIG.c_include_s2mm {$s2mm}] [get_bd_cells adma_$1]"

# Set channel's data and address width and burst width.
mm2s_burst_size=2
s2mm_burst_size=2
if [[ $mm2s -eq 1 ]]; then
    [[ ${adma_mm_dw[i]} -lt 256 ]] && mm2s_burst_size=$((512 / ${adma_mm_dw[i]}))
    add_tcl "set_property -dict [list CONFIG.c_m_axi_mm2s_data_width {${adma_mm_dw[i]}} CONFIG.c_m_axis_mm2s_tdata_width {${adma_s_dw[i]}} CONFIG.c_mm2s_burst_size {$mm2s_burst_size}] [get_bd_cells adma_$1]"
    
    add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins adma_$1/M_AXIS_MM2S]"
    add_tcl "set_property name M_AXIS_ADMA_MM2S${i} [get_bd_intf_ports M_AXIS_MM2S_0]"
    if [[ $clk1_assoc_busif == "" ]]; then
        clk1_assoc_busif="M_AXIS_ADMA_MM2S${i}"
    else
        clk1_assoc_busif="${clk1_assoc_busif}:M_AXIS_ADMA_MM2S${i}"
    fi
fi
if [[ $s2mm -eq 1 ]]; then
    [[ ${adma_mm_dw[i]} -lt 256 ]] && s2mm_burst_size=$((512 / ${adma_mm_dw[i]}))
    add_tcl "set_property -dict [list CONFIG.c_m_axi_s2mm_data_width {${adma_mm_dw[i]}} CONFIG.c_s_axis_s2mm_tdata_width {${adma_s_dw[i]}} CONFIG.c_s2mm_burst_size {$s2mm_burst_size}] [get_bd_cells adma_$1]"
    
    add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins adma_$1/S_AXIS_S2MM]"
    add_tcl "set_property name S_AXIS_ADMA_S2MM${i} [get_bd_intf_ports S_AXIS_S2MM_0]"
    if [[ $clk1_assoc_busif == "" ]]; then
        clk1_assoc_busif="S_AXIS_ADMA_S2MM${i}"
    else
        clk1_assoc_busif="${clk1_assoc_busif}:S_AXIS_ADMA_S2MM${i}"
    fi
fi
add_tcl "set_property CONFIG.ASSOCIATED_BUSIF {$clk1_assoc_busif} [get_bd_ports /clk_out2]"

# Assign memory-map channel to interconnect and zynq
if [[ ${adma_dir[i]} == "read" ]]; then
    add_tcl "connect_bd_intf_net [get_bd_intf_pins adma_$1/M_AXI_MM2S] -boundary_type upper [get_bd_intf_pins $ic/S${s_axi_assign_r}_AXI]"
    add_tcl "set_property -dict [list CONFIG.S${s_axi_assign_r}_HAS_REGSLICE {3}] [get_bd_cells $ic]"
    add_tcl "connect_bd_net [get_bd_pins adma_$1/m_axi_mm2s_aclk] [get_bd_pins clk_wiz_0/clk_out2]"
    add_tcl "connect_bd_net [get_bd_pins $ic/S${s_axi_assign_r}_ACLK] [get_bd_pins clk_wiz_0/clk_out2]"
    add_tcl "connect_bd_net [get_bd_pins $ic/S${s_axi_assign_r}_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]"
    add_bus_port "s_axi_assign_r" 1
elif [[ ${adma_dir[i]} == "write" ]]; then
    add_tcl "connect_bd_intf_net [get_bd_intf_pins adma_$1/M_AXI_S2MM] -boundary_type upper [get_bd_intf_pins $ic/S${s_axi_assign_r}_AXI]"
    add_tcl "set_property -dict [list CONFIG.S${s_axi_assign_r}_HAS_REGSLICE {3}] [get_bd_cells $ic]"
    add_tcl "connect_bd_net [get_bd_pins adma_$1/m_axi_s2mm_aclk] [get_bd_pins clk_wiz_0/clk_out2]"
    add_bus_port "s_axi_assign_r" 1
else
    add_tcl "connect_bd_intf_net [get_bd_intf_pins adma_$1/M_AXI_MM2S] -boundary_type upper [get_bd_intf_pins $ic/S${s_axi_assign_r}_AXI]"
    add_tcl "connect_bd_net [get_bd_pins $ic/S${s_axi_assign_r}_ACLK] [get_bd_pins clk_wiz_0/clk_out2]"
    add_tcl "connect_bd_net [get_bd_pins $ic/S${s_axi_assign_r}_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]"
    add_bus_port "s_axi_assign_r" 1
    add_tcl "connect_bd_intf_net [get_bd_intf_pins adma_$1/M_AXI_S2MM] -boundary_type upper [get_bd_intf_pins $ic/S${s_axi_assign_r}_AXI]"
    add_tcl "connect_bd_net [get_bd_pins $ic/S${s_axi_assign_r}_ACLK] [get_bd_pins clk_wiz_0/clk_out2]"
    add_tcl "connect_bd_net [get_bd_pins $ic/S${s_axi_assign_r}_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]"
    add_bus_port "s_axi_assign_r" 1
    add_tcl "set_property -dict [list CONFIG.S${s_axi_assign_r}_HAS_REGSLICE {3} CONFIG.S${s_axi_assign_r}_HAS_REGSLICE {3}] [get_bd_cells $ic]"
    add_tcl "connect_bd_net [get_bd_pins adma_$1/m_axi_mm2s_aclk] [get_bd_pins clk_wiz_0/clk_out2]"
    add_tcl "connect_bd_net [get_bd_pins adma_$1/m_axi_s2mm_aclk] [get_bd_pins clk_wiz_0/clk_out2]"
fi

# Assign axi lite.
add_tcl "connect_bd_intf_net [get_bd_intf_pins adma_$1/S_AXI_LITE] -boundary_type upper [get_bd_intf_pins axi_ic_m_gp0/M${axil_assign_r}_AXI]"
add_tcl "connect_bd_net [get_bd_pins axi_ic_m_gp0/M${axil_assign_r}_ACLK] [get_bd_pins clk_wiz_0/clk_out3]"
add_tcl "connect_bd_net [get_bd_pins axi_ic_m_gp0/M${axil_assign_r}_ARESETN] [get_bd_pins proc_sys_reset_2/peripheral_aresetn]"
add_tcl "connect_bd_net [get_bd_pins adma_$1/s_axi_lite_aclk] [get_bd_pins clk_wiz_0/clk_out3]"
add_tcl "connect_bd_net [get_bd_pins adma_$1/axi_resetn] [get_bd_pins proc_sys_reset_2/peripheral_aresetn]"
add_bus_port "axil_assign_r" 1

# Assign axil lite address space.
# add_tcl "assign_bd_address -target_address_space /processing_system7_0/Data [get_bd_addr_segs adma_$1/S_AXI_LITE/Reg] -force"
# add_tcl "set_property offset 0x40${m_axi_gp0_addr_assign}00000 [get_bd_addr_segs {processing_system7_0/Data/SEG_adma_$1_Reg}]"
# add_tcl "set_property range $m_axi_gp0_addr_range [get_bd_addr_segs {processing_system7_0/Data/SEG_adma_$1_Reg}]"
# m_axi_gp0_addr_assign=$((m_axi_gp0_addr_assign+1))

# Assign axi hp slave address space.
# up_port="${adma_data_port[i]^^}"
# add_tcl "assign_bd_address -target_address_space /adma_$1/Data_MM2S [get_bd_addr_segs processing_system7_0/S_AXI_${up_port}/${up_port}_DDR_LOWOCM] -force"
# add_tcl "assign_bd_address -target_address_space /adma_$1/Data_S2MM [get_bd_addr_segs processing_system7_0/S_AXI_${up_port}/${up_port}_DDR_LOWOCM] -force"

# Add define to pre_proc.vh.
#****************************************************************
add_define "USE_AXI_DMA_${i}"
if [[ ${adma_dir[i]} == "write" ]]; then
    add_define "USE_AXI_DMA_WRITE_${i}"
elif [[ ${adma_dir[i]} == "read" ]]; then
    add_define "USE_AXI_DMA_READ_${i}"
else
    add_define "USE_AXI_DMA_WRITE_${i}"    
    add_define "USE_AXI_DMA_READ_${i}"
fi
add_define "AXI_DMA_AW_${i}" "${adma_aw[i]}"
add_define "AXI_DMA_MM_DW_${i}" "${adma_mm_dw[i]}"
add_define "AXI_DMA_S_DW_${i}" "${adma_s_dw[i]}"
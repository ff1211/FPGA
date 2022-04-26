#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# axi_int.sh
# 
# Description:
# Bash shell for add interconnect ip.
# Sourced by add_ip.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.22  fanfei      Initial version
#****************************************************************

# Add ip
#****************************************************************
echo "startgroup" >> "$add_ip_tcl_path"
echo "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0" >> "$add_ip_tcl_path"
echo "endgroup" >> "$add_ip_tcl_path"

# Set AXI clock convert.
#****************************************************************
# Make external.
echo "startgroup" >> "$add_ip_tcl_path"
echo "make_bd_pins_external  [get_bd_pins axi_clock_converter_0/m_axi_aclk] [get_bd_pins axi_clock_converter_0/s_axi_aclk] [get_bd_pins axi_clock_converter_0/s_axi_aresetn] [get_bd_pins axi_clock_converter_0/m_axi_aresetn]" >> "$add_ip_tcl_path"
echo "make_bd_intf_pins_external  [get_bd_intf_pins axi_clock_converter_0/S_AXI]" >> "$add_ip_tcl_path"
echo "endgroup" >> "$add_ip_tcl_path"
echo "set_property -dict [list CONFIG.FREQ_HZ {${clk_freq[0]}000000}] [get_bd_intf_ports S_AXI_0]" >> "$add_ip_tcl_path"
echo "set_property -dict [list CONFIG.ID_WIDTH {12}] [get_bd_intf_ports S_AXI_0]" >> "$add_ip_tcl_path"

# Set AXI protocal convert.
#****************************************************************
echo "connect_bd_net [get_bd_ports m_axi_aclk_0] [get_bd_pins axi_protocol_convert_0/aclk]" >> "$add_ip_tcl_path"
echo "connect_bd_net [get_bd_ports m_axi_aresetn_0] [get_bd_pins axi_protocol_convert_0/aresetn]" >> "$add_ip_tcl_path"
echo "connect_bd_intf_net [get_bd_intf_pins axi_clock_converter_0/M_AXI] [get_bd_intf_pins axi_protocol_convert_0/S_AXI]" >> "$add_ip_tcl_path"

# Set AXI interconnect.
#****************************************************************
echo "connect_bd_net [get_bd_ports m_axi_aclk_0] [get_bd_pins axi_interconnect_0/ACLK]" >> "$add_ip_tcl_path"
echo "connect_bd_net [get_bd_ports m_axi_aclk_0] [get_bd_pins axi_interconnect_0/S00_ACLK]" >> "$add_ip_tcl_path"
echo "connect_bd_net [get_bd_ports m_axi_aresetn_0] [get_bd_pins axi_interconnect_0/S00_ARESETN]" >> "$add_ip_tcl_path"
echo "connect_bd_intf_net [get_bd_intf_pins axi_protocol_convert_0/M_AXI] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/S00_AXI]" >> "$add_ip_tcl_path"
echo "connect_bd_net [get_bd_ports m_axi_aresetn_0] [get_bd_pins axi_interconnect_0/ARESETN]" >> "$add_ip_tcl_path"
i=0
while [[ i -ne $m_axil_num ]]; do
    echo "connect_bd_net [get_bd_ports m_axi_aclk_0] [get_bd_pins axi_interconnect_0/M0${i}_ACLK]" >> "$add_ip_tcl_path"
    echo "connect_bd_net [get_bd_ports m_axi_aresetn_0] [get_bd_pins axi_interconnect_0/M0${i}_ARESETN]" >> "$add_ip_tcl_path"
    i=$((i+1))
done

# Make external.
i=0
echo "startgroup" >> "$add_ip_tcl_path"
while [[ i -ne $m_axil_num ]]; do
    echo "make_bd_intf_pins_external  [get_bd_intf_pins axi_interconnect_0/M0${i}_AXI]" >> "$add_ip_tcl_path"
    i=$((i+1))
done
echo "endgroup" >> "$add_ip_tcl_path"

# Set address.
# GP_0_BASE_ADDR=0x40000000
# GP_0_HIGH_ADDR=0x7FFFFFFF
i=0
RANGE="64K"
while [[ i -ne $m_axil_num ]]; do
    BASE_ADDR="0x420${i}0000"
    echo "assign_bd_address -target_address_space /S_AXI_0 [get_bd_addr_segs M0${i}_AXI_0/Reg] -force" >> "$add_ip_tcl_path"
    echo "set_property offset $BASE_ADDR [get_bd_addr_segs {S_AXI_0/SEG_M0${i}_AXI_0_Reg}]" >> "$add_ip_tcl_path"
    echo "set_property range $RANGE [get_bd_addr_segs {S_AXI_0/SEG_M0${i}_AXI_0_Reg}]" >> "$add_ip_tcl_path"
    i=$((i+1))
done
# Save board design.
echo "save_bd_design" >> "$add_ip_tcl_path"

# Add define.
i=0
while [[ i -ne $m_axil_num ]]; do
    add_define "USE_M_AXIL_${i}"
    i=$((i+1))
done
add_define "M_AXIL_NUM" $m_axil_num
add_define "USE_AXIL_IC"

# Add hdl wrapper file.
add_ip_wrapper "$SHELL_DIR/common/axil_ic.sv"

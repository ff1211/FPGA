#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# zynq_ps.sh
# 
# Description:
# Bash shell for add Zynq processing system ip.
# Sourced by add_ip.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.20  ff          Initial version
#****************************************************************

# Add processing system hardcore.
if [[ $platform == "zynq-7000" ]];  then
    source "$SCRIPT_DIR/ip/zynq_ps/z7.sh"
elif [[ $platform == "zynq-ultrascale" ]]; then
    echo "Error! Haven't support Zynq-UltraScale now!"
    error
    source "$SCRIPT_DIR/ip/zynq_ps/zu.sh"
fi

# Add axi lite interconnect.
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_axil"
add_tcl "set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {$m_axil_num}] [get_bd_cells axi_interconnect_axil]"

# Assign M_AXI_GP0 to axi lite interconnect.
add_tcl "connect_bd_intf_net [get_bd_intf_pins processing_system7_0/M_AXI_GP0] -boundary_type upper [get_bd_intf_pins axi_interconnect_axil/S00_AXI]"
# Assign axi lite interconnect slave and interconnect port.
add_tcl "connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins axi_interconnect_axil/S00_ACLK]"
add_tcl "connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins axi_interconnect_axil/S00_ARESETN]"
add_tcl "connect_bd_net [get_bd_pins proc_sys_reset_0/interconnect_aresetn] [get_bd_pins axi_interconnect_axil/ARESETN]"
add_tcl "connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins axi_interconnect_axil/ACLK]"

# Make M00_AXI external, for system check module in shell.
add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins axi_interconnect_axil/M00_AXI]"
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_axil/M00_ACLK] [get_bd_pins clk_wiz_0/clk_out3]"
add_tcl "connect_bd_net [get_bd_pins axi_interconnect_axil/M00_ARESETN] [get_bd_pins proc_sys_reset_2/peripheral_aresetn]"
add_tcl "set_property name M_AXIL_CHECK [get_bd_intf_ports M00_AXI_0]"
add_tcl "set_property -dict [list CONFIG.PROTOCOL {AXI4LITE}] [get_bd_intf_ports M_AXIL_CHECK]"
export clk2_assoc_busif="M_AXIL_CHECK"

# Assign address space.
add_tcl "assign_bd_address -target_address_space /processing_system7_0/Data [get_bd_addr_segs M_AXIL_CHECK/Reg] -force"
add_tcl "set_property offset 0x4${m_axi_gp0_addr_assign}000000 [get_bd_addr_segs {processing_system7_0/Data/SEG_M_AXIL_CHECK_Reg}]"
add_tcl "set_property range $axil_addr_range [get_bd_addr_segs {processing_system7_0/Data/SEG_M_AXIL_CHECK_Reg}]"
export m_axi_gp0_addr_assign=$((m_axi_gp0_addr_assign+1))

# Make user defined axi lite external, for exteranl user's ip;
i=0
while [[ $i -ne $m_axil_user_num ]]; do
    j=$((i+1))
    add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins axi_interconnect_axil/M0${j}_AXI]"
    add_tcl "connect_bd_net [get_bd_pins axi_interconnect_axil/M0${j}_ACLK] [get_bd_pins clk_wiz_0/clk_out3]"
    add_tcl "connect_bd_net [get_bd_pins axi_interconnect_axil/M0${j}_ARESETN] [get_bd_pins proc_sys_reset_2/peripheral_aresetn]"
    add_tcl "set_property name M_AXIL_USER${i} [get_bd_intf_ports M0${j}_AXI_0]"
    add_tcl "set_property -dict [list CONFIG.PROTOCOL {AXI4LITE}] [get_bd_intf_ports M_AXIL_USER${i}]"
    export clk2_assoc_busif="$clk2_assoc_busif:M_AXIL_USER${i}"

    # Assign address space.
    add_tcl "assign_bd_address -target_address_space /processing_system7_0/Data [get_bd_addr_segs M_AXIL_USER${i}/Reg] -force"
    add_tcl "set_property offset 0x4${m_axi_gp0_addr_assign}000000 [get_bd_addr_segs {processing_system7_0/Data/SEG_M_AXIL_USER${i}_Reg}]"
    add_tcl "set_property range $axil_addr_range [get_bd_addr_segs {processing_system7_0/Data/SEG_M_AXIL_USER${i}_Reg}]"
    export m_axi_gp0_addr_assign=$((m_axi_gp0_addr_assign+1))

    i=$((i+1))
done
add_tcl "set_property CONFIG.ASSOCIATED_BUSIF {$clk2_assoc_busif} [get_bd_ports /clk_out3]"

# Assign clock wizzard.
add_tcl "connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins clk_wiz_0/clk_in1]"

# Assign system reset.
i=0
while [[ $i -ne ${#clk_freq[@]} ]]; do
    add_tcl "connect_bd_net [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins proc_sys_reset_${i}/ext_reset_in]"
    i=$((i+1))
done

# Add wrapper.
add_ip_wrapper "$SHELL_DIR/common/sys.sv"
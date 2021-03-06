#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# z7.sh
# 
# Description:
# Bash shell for add Zynq-7000 processing system ip.
# Sourced by zynq_ps.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.05.23  ff          Initial version
#****************************************************************

# Add ip.
add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0"
# Source preset.
add_tcl "source $BOARDS_DIR/$board_name/ps_preset.tcl"
add_tcl "set_property -dict [apply_preset processing_system7_0] [get_bd_cells processing_system7_0]"
# Config AXI port.

i=0
while [[ $i -ne 2 ]]; do
    num="m_axi_gp${i}_num"
    if [[ ${!num} -ne 0 ]]; then 
        # Enable M_AXI_GP port and assign clock.
        add_tcl "set_property -dict [list CONFIG.PCW_USE_M_AXI_GP${i} {1}] [get_bd_cells processing_system7_0]"
        add_tcl "connect_bd_net [get_bd_pins processing_system7_0/M_AXI_GP${i}_ACLK] [get_bd_pins clk_wiz_0/clk_out1]"
        # Add AXI Interconnect and config master port number.
        add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ic_m_gp${i}"
        add_tcl "set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {${!num}}] [get_bd_cells axi_ic_m_gp${i}]"
        # Assign AXI Interconnect slave port to zynq's M_AXI_GP.
        add_tcl "connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins axi_ic_m_gp${i}/ACLK]"
        add_tcl "connect_bd_net [get_bd_pins proc_sys_reset_0/interconnect_aresetn] [get_bd_pins axi_ic_m_gp${i}/ARESETN]"
        add_tcl "connect_bd_intf_net [get_bd_intf_pins processing_system7_0/M_AXI_GP${i}] -boundary_type upper [get_bd_intf_pins axi_ic_m_gp${i}/S00_AXI]"
        add_tcl "connect_bd_net [get_bd_pins axi_ic_m_gp${i}/S00_ACLK] [get_bd_pins clk_wiz_0/clk_out1]"
        add_tcl "connect_bd_net [get_bd_pins axi_ic_m_gp${i}/S00_ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]"
    fi
    i=$((i+1))
done
i=0
while [[ $i -ne 2 ]]; do
    num="s_axi_gp${i}_num"
    if [[ ${!num} -ne 0 ]]; then
        # Enable S_AXI_GP port and assign clock.
        add_tcl "set_property -dict [list CONFIG.PCW_USE_S_AXI_GP${i} {1}] [get_bd_cells processing_system7_0]"
        add_tcl "connect_bd_net [get_bd_pins processing_system7_0/S_AXI_GP${i}_ACLK] [get_bd_pins clk_wiz_0/clk_out1]"
        # Add AXI Interconnect and config slave port number.
        add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ic_s_gp${i}"
        add_tcl "set_property -dict [list CONFIG.NUM_SI {${!num}} CONFIG.NUM_MI {1}] [get_bd_cells axi_ic_s_gp${i}]"
        # Assign AXI Interconnect master port to zynq's S_AXI_GP.
        add_tcl "connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins axi_ic_s_gp${i}/ACLK]"
        add_tcl "connect_bd_net [get_bd_pins proc_sys_reset_0/interconnect_aresetn] [get_bd_pins axi_ic_s_gp${i}/ARESETN]"
        add_tcl "connect_bd_intf_net [get_bd_intf_pins processing_system7_0/S_AXI_GP${i}] -boundary_type upper [get_bd_intf_pins axi_ic_s_gp${i}/M00_AXI]"
        add_tcl "connect_bd_net [get_bd_pins axi_ic_s_gp${i}/M00_ACLK] [get_bd_pins clk_wiz_0/clk_out1]"
        add_tcl "connect_bd_net [get_bd_pins axi_ic_s_gp${i}/M00_ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]"
    fi
    i=$((i+1))
done
i=0
while [[ $i -ne 4 ]]; do
    num="s_axi_hp${i}_num"
    if [[ ${!num} -ne 0 ]]; then
        # Enable S_AXI_HP port and assign clock.
        add_tcl "set_property -dict [list CONFIG.PCW_USE_S_AXI_HP${i} {1}] [get_bd_cells processing_system7_0]"
        add_tcl "connect_bd_net [get_bd_pins processing_system7_0/S_AXI_HP${i}_ACLK] [get_bd_pins clk_wiz_0/clk_out2]"
        # Add AXI Interconnect and config slave port number.
        add_tcl "create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ic_s_hp${i}"
        add_tcl "set_property -dict [list CONFIG.NUM_SI {${!num}} CONFIG.NUM_MI {1}] [get_bd_cells axi_ic_s_hp${i}]"        
        # Assign AXI Interconnect master port to zynq's S_AXI_HP.
        add_tcl "connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins axi_ic_s_hp${i}/ACLK]"
        add_tcl "connect_bd_net [get_bd_pins proc_sys_reset_0/interconnect_aresetn] [get_bd_pins axi_ic_s_hp${i}/ARESETN]"
        add_tcl "connect_bd_intf_net [get_bd_intf_pins processing_system7_0/S_AXI_HP${i}] -boundary_type upper [get_bd_intf_pins axi_ic_s_hp${i}/M00_AXI]"
        add_tcl "connect_bd_net [get_bd_pins axi_ic_s_hp${i}/M00_ACLK] [get_bd_pins clk_wiz_0/clk_out2]"
        add_tcl "connect_bd_net [get_bd_pins axi_ic_s_hp${i}/M00_ARESETN] [get_bd_pins proc_sys_reset_1/interconnect_aresetn]"
    fi
    i=$((i+1))
done

# Make external.
add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins processing_system7_0/DDR]"
add_tcl "set_property name DDR [get_bd_intf_ports DDR_0]"
add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins processing_system7_0/FIXED_IO]"
add_tcl "set_property name FIXED_IO [get_bd_intf_ports FIXED_IO_0]"
add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins processing_system7_0/USBIND_0]"
add_tcl "set_property name USBIND [get_bd_intf_ports USBIND_0_0]"

# Make M00_AXI external, for system check module in shell.
add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins axi_ic_m_gp0/M00_AXI]"
add_tcl "connect_bd_net [get_bd_pins axi_ic_m_gp0/M00_ACLK] [get_bd_pins clk_wiz_0/clk_out3]"
add_tcl "connect_bd_net [get_bd_pins axi_ic_m_gp0/M00_ARESETN] [get_bd_pins proc_sys_reset_2/peripheral_aresetn]"
add_tcl "set_property name M_AXIL_CHECK [get_bd_intf_ports M00_AXI_0]"
add_tcl "set_property -dict [list CONFIG.PROTOCOL {AXI4LITE}] [get_bd_intf_ports M_AXIL_CHECK]"
clk2_assoc_busif="M_AXIL_CHECK"
add_bus_port "axil_assign_r" 1

# Assign address space.
# add_tcl "assign_bd_address -target_address_space /processing_system7_0/Data [get_bd_addr_segs M_AXIL_CHECK/Reg] -force"
# add_tcl "set_property offset 0x40${m_axi_gp0_addr_assign}00000 [get_bd_addr_segs {processing_system7_0/Data/SEG_M_AXIL_CHECK_Reg}]"
# add_tcl "set_property range $m_axi_gp0_addr_range [get_bd_addr_segs {processing_system7_0/Data/SEG_M_AXIL_CHECK_Reg}]"
# m_axi_gp0_addr_assign=$((m_axi_gp0_addr_assign+1))

# Make user defined axi lite external, for exteranl user's ip;
i=0
while [[ $i -ne $m_axil_user_num ]]; do
    add_tcl "make_bd_intf_pins_external  [get_bd_intf_pins axi_ic_m_gp0/M${axil_assign_r}_AXI]"
    add_tcl "connect_bd_net [get_bd_pins axi_ic_m_gp0/M${axil_assign_r}_ACLK] [get_bd_pins clk_wiz_0/clk_out3]"
    add_tcl "connect_bd_net [get_bd_pins axi_ic_m_gp0/M${axil_assign_r}_ARESETN] [get_bd_pins proc_sys_reset_2/peripheral_aresetn]"
    add_tcl "set_property name M_AXIL_USER${i} [get_bd_intf_ports M${axil_assign_r}_AXI_0]"
    add_tcl "set_property -dict [list CONFIG.PROTOCOL {AXI4LITE}] [get_bd_intf_ports M_AXIL_USER${i}]"
    clk2_assoc_busif="$clk2_assoc_busif:M_AXIL_USER${i}"
    add_bus_port "axil_assign_r" 1

    # Assign address space.
    # add_tcl "assign_bd_address -target_address_space /processing_system7_0/Data [get_bd_addr_segs M_AXIL_USER${i}/Reg] -force"
    # add_tcl "set_property offset 0x40${m_axi_gp0_addr_assign}00000 [get_bd_addr_segs {processing_system7_0/Data/SEG_M_AXIL_USER${i}_Reg}]"
    # add_tcl "set_property range $m_axi_gp0_addr_range [get_bd_addr_segs {processing_system7_0/Data/SEG_M_AXIL_USER${i}_Reg}]"
    # m_axi_gp0_addr_assign=$((m_axi_gp0_addr_assign+1))

    i=$((i+1))
done

add_tcl "set_property -dict [list CONFIG.PCW_USE_CROSS_TRIGGER {0} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]"
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
add_file "$SHELL_DIR/common/sys.sv"
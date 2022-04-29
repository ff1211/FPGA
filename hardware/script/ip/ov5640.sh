#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# ov5640.sh
# 
# Description:
# Bash shell for create ov5640 camera ip.
# Sourced by add_ip.sh.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.28  fanfei      Initial version
#****************************************************************

# Add axi_iic ip for config ov5640.
add_tcl "create_ip -name axi_iic -vendor xilinx.com -library ip -version 2.1 -module_name axi_iic_ov5640"
add_tcl "set_property -dict [list CONFIG.AXI_ACLK_FREQ_MHZ {${clk_freq[2]}}] [get_ips axi_iic_ov5640]"
add_tcl "set_property -dict [list CONFIG.IIC_FREQ_KHZ {250}] [get_ips axi_iic_ov5640]"

vsync_pulse=5688



# Add define.
add_define "USE_OV5640"


# localparam H_SYNC_PULSE     = 96;
# localparam H_BACK_PORCH     = 48;
# localparam H_FRONT_PORCH    = 16;
# localparam WHOLE_LINE       = 800;

# localparam V_SYNC_PULSE     = 2;
# localparam V_BACK_PORCH     = 33;
# localparam V_FRONT_PORCH    = 10;
# localparam WHOLE_FRAME      = 525;

# Add ip wrapper.
add_ip_wrapper "$SHELL_DIR/ov5640/ov5640.sv"


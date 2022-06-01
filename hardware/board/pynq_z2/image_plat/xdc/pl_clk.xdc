#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# pl_clk.xdc
# 
# Description:
# Constrain file for pynq_z2 pl clock.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.06.01  ff          Initial version
#****************************************************************

set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports pl_clk];
create_clock -name pl_clk -period 8 [get_ports pl_clk]
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# pl_clk.xdc
# 
# Description:
# Constrain file for zedboard pl clock.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.28  ff          Initial version
#****************************************************************

# Clock Source - Bank 13
set_property PACKAGE_PIN Y9 [get_ports {pl_clk}];
create_clock -name pl_clk -period 10 [get_ports pl_clk]

# Note that the bank voltage for IO Bank 13 is fixed to 3.3V on ZedBoard. 
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
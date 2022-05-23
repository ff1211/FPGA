#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# board.xdc
# 
# Description:
# Constrain file for zedboard.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  ff          Initial version
#****************************************************************

# Clock Source - Bank 13
set_property PACKAGE_PIN Y9 [get_ports {pl_clk}];
create_clock -name pl_clk -period 10 [get_ports pl_clk]

# Set the bank voltage for IO Bank 34 to 1.8V by default.
#****************************************************************
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];
# set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 34]];
# set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];

# Set the bank voltage for IO Bank 35 to 1.8V by default.
#****************************************************************
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];
# set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 35]];
# set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];

# Note that the bank voltage for IO Bank 33 is fixed to 3.3V on ZedBoard.
#****************************************************************
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];

# Note that the bank voltage for IO Bank 13 is fixed to 3.3V on ZedBoard. 
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
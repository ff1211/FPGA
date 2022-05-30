#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# vga.xdc
# 
# Description:
# Constrain file for zedboard vga connector.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.28  ff          Initial version
#****************************************************************

#****************************************************************
# VGA Output - Bank 33
#****************************************************************
set_property PACKAGE_PIN V20  [get_ports {vga_r[0]}];
set_property PACKAGE_PIN U20  [get_ports {vga_r[1]}];
set_property PACKAGE_PIN V19  [get_ports {vga_r[2]}];
set_property PACKAGE_PIN V18  [get_ports {vga_r[3]}];
set_property PACKAGE_PIN AB22 [get_ports {vga_g[0]}];
set_property PACKAGE_PIN AA22 [get_ports {vga_g[1]}];
set_property PACKAGE_PIN AB21 [get_ports {vga_g[2]}];
set_property PACKAGE_PIN AA21 [get_ports {vga_g[3]}];
set_property PACKAGE_PIN Y21  [get_ports {vga_b[0]}];
set_property PACKAGE_PIN Y20  [get_ports {vga_b[1]}];
set_property PACKAGE_PIN AB20 [get_ports {vga_b[2]}];
set_property PACKAGE_PIN AB19 [get_ports {vga_b[3]}];
set_property PACKAGE_PIN AA19 [get_ports {vga_hsync}];
set_property PACKAGE_PIN Y19  [get_ports {vga_vsync}];

# Note that the bank voltage for IO Bank 33 is fixed to 3.3V on ZedBoard. 
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
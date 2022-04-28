#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# board.xdc
# 
# Description:
# Constrain file for zedboard pl push buttons.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.28  fanfei      Initial version
#****************************************************************

set_property PACKAGE_PIN P16 [get_ports {btn_c}];  # "BTNC"
set_property PACKAGE_PIN R16 [get_ports {btn_d}];  # "BTND"
set_property PACKAGE_PIN N15 [get_ports {btn_l}];  # "BTNL"
set_property PACKAGE_PIN R18 [get_ports {btn_r}];  # "BTNR"
set_property PACKAGE_PIN T18 [get_ports {btn_u}];  # "BTNU"

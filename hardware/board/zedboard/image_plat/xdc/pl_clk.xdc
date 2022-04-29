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
# 1.0      2022.04.28  fanfei      Initial version
#****************************************************************

# Clock Source - Bank 13
set_property PACKAGE_PIN Y9 [get_ports {pl_clk}];
create_clock -name pl_clk -period 10 [get_ports pl_clk]
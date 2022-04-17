#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# pmod.xdc
# 
# Description:
# Constrain file for zedboard pmod connector.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.17  Fanfei      Initial version
#****************************************************************

#****************************************************************
# JA Pmod - Bank 13 
#****************************************************************
set_property PACKAGE_PIN Y11  [get_ports {pmod_a[0]}];
set_property PACKAGE_PIN AA11 [get_ports {pmod_a[1]}];
set_property PACKAGE_PIN Y10  [get_ports {pmod_a[2]}];
set_property PACKAGE_PIN AA9  [get_ports {pmod_a[3]}];
set_property PACKAGE_PIN AB11 [get_ports {pmod_a[4]}];
set_property PACKAGE_PIN AB10 [get_ports {pmod_a[5]}];
set_property PACKAGE_PIN AB9  [get_ports {pmod_a[6]}];
set_property PACKAGE_PIN AA8  [get_ports {pmod_a[7]}];

#****************************************************************
# JB Pmod - Bank 13 
#****************************************************************
set_property PACKAGE_PIN W12 [get_ports {pmod_b[0]}];
set_property PACKAGE_PIN W11 [get_ports {pmod_b[1]}];
set_property PACKAGE_PIN V10 [get_ports {pmod_b[2]}];
set_property PACKAGE_PIN W8  [get_ports {pmod_b[3]}];
set_property PACKAGE_PIN V12 [get_ports {pmod_b[4]}];
set_property PACKAGE_PIN W10 [get_ports {pmod_b[5]}];
set_property PACKAGE_PIN V9  [get_ports {pmod_b[6]}];
set_property PACKAGE_PIN V8  [get_ports {pmod_b[7]}];

#****************************************************************
# JC Pmod - Bank 13 
#****************************************************************
set_property PACKAGE_PIN AB7 [get_ports {pmod_c_p[0]}];
set_property PACKAGE_PIN Y4  [get_ports {pmod_c_p[1]}];
set_property PACKAGE_PIN R6  [get_ports {pmod_c_p[2]}];
set_property PACKAGE_PIN T4  [get_ports {pmod_c_p[3]}];
set_property PACKAGE_PIN AB6 [get_ports {pmod_c_n[0]}];
set_property PACKAGE_PIN AA4 [get_ports {pmod_c_n[1]}];
set_property PACKAGE_PIN T6  [get_ports {pmod_c_n[2]}];
set_property PACKAGE_PIN U4  [get_ports {pmod_c_n[3]}];

#****************************************************************
# JD Pmod - Bank 13 
#****************************************************************
set_property PACKAGE_PIN V7 [get_ports {pmod_d_p[0]}];
set_property PACKAGE_PIN V5 [get_ports {pmod_d_p[1]}];
set_property PACKAGE_PIN W6 [get_ports {pmod_d_p[2]}];
set_property PACKAGE_PIN U6 [get_ports {pmod_d_p[3]}];
set_property PACKAGE_PIN W7 [get_ports {pmod_d_n[0]}];
set_property PACKAGE_PIN V4 [get_ports {pmod_d_n[1]}];
set_property PACKAGE_PIN W5 [get_ports {pmod_d_n[2]}];
set_property PACKAGE_PIN U5 [get_ports {pmod_d_n[3]}];


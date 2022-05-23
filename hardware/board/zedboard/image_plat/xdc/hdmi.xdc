#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# hdmi.xdc
# 
# Description:
# Constrain file for zedboard hdmi connector.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.17  ff          Initial version
#****************************************************************

#****************************************************************
# HDMI Output - Bank 33
#****************************************************************
set_property PACKAGE_PIN W18  [get_ports {hdmi_clk}]; 
set_property PACKAGE_PIN Y13  [get_ports {hdmi_d[0]}];
set_property PACKAGE_PIN AA13 [get_ports {hdmi_d[1]}];
set_property PACKAGE_PIN AA14 [get_ports {hdmi_d[2]}];
set_property PACKAGE_PIN Y14  [get_ports {hdmi_d[3]}];
set_property PACKAGE_PIN AB15 [get_ports {hdmi_d[4]}];
set_property PACKAGE_PIN AB16 [get_ports {hdmi_d[5]}];
set_property PACKAGE_PIN AA16 [get_ports {hdmi_d[6]}];
set_property PACKAGE_PIN AB17 [get_ports {hdmi_d[7]}];
set_property PACKAGE_PIN AA17 [get_ports {hdmi_d[8]}];
set_property PACKAGE_PIN Y15  [get_ports {hdmi_d[9]}];
set_property PACKAGE_PIN W13  [get_ports {hdmi_d[10]}];
set_property PACKAGE_PIN W15  [get_ports {hdmi_d[11]}];
set_property PACKAGE_PIN V15  [get_ports {hdmi_d[12]}];
set_property PACKAGE_PIN U17  [get_ports {hdmi_d[13]}];
set_property PACKAGE_PIN V14  [get_ports {hdmi_d[14]}];
set_property PACKAGE_PIN V13  [get_ports {hdmi_d[15]}];
set_property PACKAGE_PIN U16  [get_ports {hdmi_de}];
set_property PACKAGE_PIN W16  [get_ports {hdmi_int}];
set_property PACKAGE_PIN AA18 [get_ports {hdmi_scl}];
set_property PACKAGE_PIN Y16  [get_ports {hdmi_sda}];
set_property PACKAGE_PIN U15  [get_ports {hdmi_spdif}]; 
set_property PACKAGE_PIN Y18  [get_ports {hdmi_spdifo}];
set_property PACKAGE_PIN W17  [get_ports {hdmi_vsync}];
set_property PACKAGE_PIN V17  [get_ports {hdmi_hsync}];
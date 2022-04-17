#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# fmc.xdc
# 
# Description:
# Constrain file for zedboard fmc connector.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************

#****************************************************************
# FMC Expansion Connector - Bank 13
#****************************************************************
set_property PACKAGE_PIN R7 [get_ports {fmc_scl}];
set_property PACKAGE_PIN U7 [get_ports {fmc_sda}];

#****************************************************************
# FMC Expansion Connector - Bank 33
#****************************************************************
set_property PACKAGE_PIN AB14 [get_ports {fmc_rst_n}];

#****************************************************************
# FMC Expansion Connector - Bank 34
#****************************************************************
set_property PACKAGE_PIN L19 [get_ports {fmc_CLK0_n}];
set_property PACKAGE_PIN L18 [get_ports {fmc_CLK0_p}];
set_property PACKAGE_PIN M20 [get_ports {fmc_la00_CC_n}];
set_property PACKAGE_PIN M19 [get_ports {fmc_la00_CC_p}];
set_property PACKAGE_PIN N20 [get_ports {fmc_la01_CC_n}];
set_property PACKAGE_PIN N19 [get_ports {fmc_la01_CC_p}];
set_property PACKAGE_PIN P18 [get_ports {fmc_la02_n}];
set_property PACKAGE_PIN P17 [get_ports {fmc_la02_p}];
set_property PACKAGE_PIN P22 [get_ports {fmc_la03_n}];
set_property PACKAGE_PIN N22 [get_ports {fmc_la03_p}];
set_property PACKAGE_PIN M22 [get_ports {fmc_la04_n}];
set_property PACKAGE_PIN M21 [get_ports {fmc_la04_p}];
set_property PACKAGE_PIN K18 [get_ports {fmc_la05_n}];
set_property PACKAGE_PIN J18 [get_ports {fmc_la05_p}];
set_property PACKAGE_PIN L22 [get_ports {fmc_la06_n}];
set_property PACKAGE_PIN L21 [get_ports {fmc_la06_p}];
set_property PACKAGE_PIN T17 [get_ports {fmc_la07_n}];
set_property PACKAGE_PIN T16 [get_ports {fmc_la07_p}];
set_property PACKAGE_PIN J22 [get_ports {fmc_la08_n}];
set_property PACKAGE_PIN J21 [get_ports {fmc_la08_p}];
set_property PACKAGE_PIN R21 [get_ports {fmc_la09_n}];
set_property PACKAGE_PIN R20 [get_ports {fmc_la09_p}];
set_property PACKAGE_PIN T19 [get_ports {fmc_la10_n}];
set_property PACKAGE_PIN R19 [get_ports {fmc_la10_p}];
set_property PACKAGE_PIN N18 [get_ports {fmc_la11_n}];
set_property PACKAGE_PIN N17 [get_ports {fmc_la11_p}];
set_property PACKAGE_PIN P21 [get_ports {fmc_la12_n}];
set_property PACKAGE_PIN P20 [get_ports {fmc_la12_p}];
set_property PACKAGE_PIN M17 [get_ports {fmc_la13_n}];
set_property PACKAGE_PIN L17 [get_ports {fmc_la13_p}];
set_property PACKAGE_PIN K20 [get_ports {fmc_la14_n}];
set_property PACKAGE_PIN K19 [get_ports {fmc_la14_p}];
set_property PACKAGE_PIN J17 [get_ports {fmc_la15_n}];
set_property PACKAGE_PIN J16 [get_ports {fmc_la15_p}];
set_property PACKAGE_PIN K21 [get_ports {fmc_la16_n}];
set_property PACKAGE_PIN J20 [get_ports {fmc_la16_p}];

#****************************************************************
# FMC Expansion Connector - Bank 35
#****************************************************************
set_property PACKAGE_PIN C19 [get_ports {fmc_clk1_n}];
set_property PACKAGE_PIN D18 [get_ports {fmc_clk1_p}];
set_property PACKAGE_PIN B20 [get_ports {fmc_la17_CC_n}];
set_property PACKAGE_PIN B19 [get_ports {fmc_la17_CC_p}];
set_property PACKAGE_PIN C20 [get_ports {fmc_la18_CC_n}];
set_property PACKAGE_PIN D20 [get_ports {fmc_la18_CC_p}];
set_property PACKAGE_PIN G16 [get_ports {fmc_la19_n}];
set_property PACKAGE_PIN G15 [get_ports {fmc_la19_p}];
set_property PACKAGE_PIN G21 [get_ports {fmc_la20_n}];
set_property PACKAGE_PIN G20 [get_ports {fmc_la20_p}];
set_property PACKAGE_PIN E20 [get_ports {fmc_la21_n}];
set_property PACKAGE_PIN E19 [get_ports {fmc_la21_p}];
set_property PACKAGE_PIN F19 [get_ports {fmc_la22_n}];
set_property PACKAGE_PIN G19 [get_ports {fmc_la22_p}];
set_property PACKAGE_PIN D15 [get_ports {fmc_la23_n}];
set_property PACKAGE_PIN E15 [get_ports {fmc_la23_p}];
set_property PACKAGE_PIN A19 [get_ports {fmc_la24_n}];
set_property PACKAGE_PIN A18 [get_ports {fmc_la24_p}];
set_property PACKAGE_PIN C22 [get_ports {fmc_la25_n}];
set_property PACKAGE_PIN D22 [get_ports {fmc_la25_p}];
set_property PACKAGE_PIN E18 [get_ports {fmc_la26_n}];
set_property PACKAGE_PIN F18 [get_ports {fmc_la26_p}];
set_property PACKAGE_PIN D21 [get_ports {fmc_la27_n}];
set_property PACKAGE_PIN E21 [get_ports {fmc_la27_p}];
set_property PACKAGE_PIN A17 [get_ports {fmc_la28_n}];
set_property PACKAGE_PIN A16 [get_ports {fmc_la28_p}];
set_property PACKAGE_PIN C18 [get_ports {fmc_la29_n}];
set_property PACKAGE_PIN C17 [get_ports {fmc_la29_p}];
set_property PACKAGE_PIN B15 [get_ports {fmc_la30_n}];
set_property PACKAGE_PIN C15 [get_ports {fmc_la30_p}];
set_property PACKAGE_PIN B17 [get_ports {fmc_la31_n}];
set_property PACKAGE_PIN B16 [get_ports {fmc_la31_p}];
set_property PACKAGE_PIN A22 [get_ports {fmc_la32_n}];
set_property PACKAGE_PIN A21 [get_ports {fmc_la32_p}];
set_property PACKAGE_PIN B22 [get_ports {fmc_la33_n}];
set_property PACKAGE_PIN B21 [get_ports {fmc_la33_p}];
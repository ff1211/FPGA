set_property PACKAGE_PIN R16 [get_ports ad_clk]
set_property IOSTANDARD LVCMOS33 [get_ports ad_clk]
set_property PACKAGE_PIN P15 [get_ports pwr]
set_property IOSTANDARD LVCMOS33 [get_ports pwr]
set_property PACKAGE_PIN T20 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
#set_property PACKAGE_PIN U18 [get_ports sysclk_i]
set_property PACKAGE_PIN P19 [get_ports {da_data[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[11]}]
set_property PACKAGE_PIN N18 [get_ports {da_data[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[10]}]
set_property PACKAGE_PIN U15 [get_ports {da_data[9]}]
set_property PACKAGE_PIN U14 [get_ports {da_data[8]}]
set_property PACKAGE_PIN T11 [get_ports {da_data[7]}]
set_property PACKAGE_PIN T10 [get_ports {da_data[6]}]
set_property PACKAGE_PIN T15 [get_ports {da_data[5]}]
set_property PACKAGE_PIN T14 [get_ports {da_data[4]}]
set_property PACKAGE_PIN U12 [get_ports {da_data[3]}]
set_property PACKAGE_PIN T12 [get_ports {da_data[2]}]
set_property PACKAGE_PIN R14 [get_ports {da_data[1]}]
set_property PACKAGE_PIN P14 [get_ports {da_data[0]}]
set_property PACKAGE_PIN U17 [get_ports {db_data[11]}]
set_property PACKAGE_PIN T16 [get_ports {db_data[10]}]
set_property PACKAGE_PIN P20 [get_ports {db_data[9]}]
set_property PACKAGE_PIN N20 [get_ports {db_data[8]}]
set_property PACKAGE_PIN W20 [get_ports {db_data[7]}]
set_property PACKAGE_PIN V20 [get_ports {db_data[6]}]
set_property PACKAGE_PIN R18 [get_ports {db_data[5]}]
set_property PACKAGE_PIN T17 [get_ports {db_data[4]}]
set_property PACKAGE_PIN P18 [get_ports {db_data[3]}]
set_property PACKAGE_PIN N17 [get_ports {db_data[2]}]
set_property PACKAGE_PIN W18 [get_ports {db_data[1]}]
set_property PACKAGE_PIN W19 [get_ports {db_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {da_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {db_data[0]}]
#set_property IOSTANDARD LVCMOS15 [get_ports sysclk_i]

create_clock -period 8 -name ad_clk [get_ports ad_clk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ad_clk]


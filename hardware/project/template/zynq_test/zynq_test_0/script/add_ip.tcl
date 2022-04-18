#****************************************************************
# This is a auto-generated file. Do not change it!
#****************************************************************
create_ip -name axi_dma -vendor xilinx.com -library ip -version 7.1 -module_name axi_dma_0
set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_include_stscntrl_strm {0}] [get_ips axi_dma_0]
set_property -dict [list CONFIG.c_include_mm2s {1} CONFIG.c_include_s2mm {0}] [get_ips axi_dma_0]
set_property -dict [list CONFIG.c_m_axi_mm2s_data_width {64} CONFIG.c_m_axis_mm2s_tdata_width {64} CONFIG.c_mm2s_burst_size {8}] [get_ips axi_dma_0]
add_files  /home/ff/git/FPGA/hardware/project/template/zynq_test/zynq_test_0/src/axi_dma.sv

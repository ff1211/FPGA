#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# pre_proc.sh
# 
# Description:
# Bash script to generate config.vh
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************

touch $cur_pj_src_dir/pre_proc.vh
pre_proc_path="$cur_pj_src_dir/pre_proc.vh"
cat > $cur_pj_src_dir/pre_proc.vh << EOF
//****************************************************************
// This is a auto-generated file. Do not change it!
//****************************************************************
EOF

# If use axi general purpose port.
if [[ ${axi_gp_port_num} -ne 0 ]]; then
    echo "\`define USE_AXI_GP_PORT" >> $pre_proc_path
    echo "\`define AXI_GP_PORT_NUM = $axi_gp_port_num" >> $pre_proc_path
fi
# If use axi high performance port.
if [[ ${axi_hp_port_num} -ne 0 ]]; then
    echo "\`define USE_AXI_HP_PORT" >> $pre_proc_path
    echo "\`define AXI_HP_PORT_NUM = $axi_hp_port_num" >> $pre_proc_path
    echo "\`define AXI_HP_PORT_DW = $axi_hp_port_dw" >> $pre_proc_path
fi
# If use axi dma.
if [[ ${use_axi_dma} -ne 0 ]]; then
    echo "\`define USE_AXI_DMA" >> $pre_proc_path
    [[ ${axi_dma_dir} != "write" ]] && echo "\`define USE_AXI_DMA_READ" >> $pre_proc_path
    [[ ${axi_dma_dir} != "read" ]] && echo "\`define USE_AXI_DMA_WRITE" >> $pre_proc_path
    echo "\`define AXI_DMA_AW = $axi_dma_aw" >> $pre_proc_path
    echo "\`define AXI_DMA_MM_DW = $axi_dma_mm_dw" >> $pre_proc_path
    echo "\`define AXI_DMA_S_DW = $axi_dma_s_dw" >> $pre_proc_path
fi
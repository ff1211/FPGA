#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# config.sh
# 
# Description:
# Bash shell for config board.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  fanfei      Initial version
#****************************************************************

# Vivado settings.
#****************************************************************
# Vivado path.
export vivado="vivado"
# If use gui.
export gui_mode=1
# Board name.
export board_name="zedboard"
# Project name.
export project_name="zynq_test"

# Shell config.
#****************************************************************
# Preset platform.
export preset_plat="basic_plat"

# Clock config.
# Max 7 clock.
# clock_0:          axi-mm gp port.
# clock_1:          axi-mm hp port. (If use dma, it is also dma's axi-stream's clock.)
# clock_2:          axi-lite.
# clock_3~clock_6:  User define clock. Not set by default.
#****************************************************************
# Haven't support change clock frequence yet!!!!!!! Set clk_freq only enable corresponding clk output port!!!!! Set frequence in ip setting page!!!!!
# Haven't support change clock frequence yet!!!!!!! Set clk_freq only enable corresponding clk output port!!!!! Set frequence in ip setting page!!!!!
# Haven't support change clock frequence yet!!!!!!! Set clk_freq only enable corresponding clk output port!!!!! Set frequence in ip setting page!!!!!
# Clock frequence, unit: MHz. Range [10, 400], integer.
export clk_freq=(100 100 100 300 100)

# Resource config.
#****************************************************************

# DMA config.
#****************************************************************
# !!! Very first Version! Haven't support lots of functions !!! #

# AXI DMA config.
#****************************************************************
# If use AXI DMA, 0 or 1.
export use_axi_dma=0
# AXI DMA mode, "block" or "scatter_gather". Only support block now.     
export axi_dma_mode="block"
# AXI dma direction, "read", "write" or "dual".
export axi_dma_dir="dual"
# AXI DMA addr width, 32 or 64.
export axi_dma_aw=32
# AXI DMA memory map data width, equal axi_hp_port_dw.          
export axi_dma_mm_dw=64
# AXI DMA stream data width, 8, 16, 32, 64, 128, 256, 512, 1024.
# Must less or equal than $axi_dma_mm_dw !!!! Check board/your_board for more information.
export axi_dma_s_dw=32
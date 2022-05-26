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
# 1.0      2022.04.14  ff          Initial version
#****************************************************************

# Vivado settings.
#****************************************************************
# Vivado path.
vivado="vivado"
# If use gui.
gui_mode=1
# Project name.
project_name="zynq_test"

# Shell config.
#****************************************************************
# Board name.
board_name="zedboard"
# Preset platform.
preset_plat="basic_plat"

# Clock config.
# Max 7 clock.
# clock_0:          axi-mm gp port.
# clock_1:          axi-mm hp port. (If use dma, it is also dma's axi-stream's clock.)
# clock_2:          axi-lite.
# clock_3~clock_6:  User define clock. Not set by default.
#****************************************************************
# Clock frequence, unit: MHz. Range [10, 400], integer.
clk_freq=(100 150 50)

# Resource config.
#****************************************************************

# DMA config.
#****************************************************************
# If use AXI DMA, 0 or 1.
use_adma=(1 1 1 1)
# Which PS slave port will adma use.
adma_data_port=("hp0" "hp1" "hp2" "hp3")
# AXI DMA mode, "block" or "scatter_gather".    
adma_mode=("scatter_gather" "scatter_gather" "scatter_gather" "scatter_gather")
# AXI dma direction, "read", "write" or "dual".
adma_dir=("dual" "dual" "dual" "dual")
# AXI DMA addr width, 32 or 64.
adma_aw=(32 32 32 32)
# AXI DMA memory map data width, equal axi_hp_port_dw.          
adma_mm_dw=(64 64 64 64)
# AXI DMA stream data width, 8, 16, 32, 64, 128, 256, 512, 1024.
# Must less or equal than $axi_dma_mm_dw !!!! Check board/your_board for more information.
adma_s_dw=(32 32 32 32)

# User defined axil port. For user's ip.
#****************************************************************
m_axil_user_num=0

# PL push button.
use_pl_btn=0
# PL clock
use_pl_clk=0


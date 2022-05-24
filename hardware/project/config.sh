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
export vivado="vivado"
# If use gui.
export gui_mode=1
# Project name.
export project_name="zynq_test"

# Shell config.
#****************************************************************
# Board name.
export board_name="zedboard"
# Preset platform.
export preset_plat="basic_plat"

# Clock config.
# Max 7 clock.
# clock_0:          axi-mm gp port.
# clock_1:          axi-mm hp port. (If use dma, it is also dma's axi-stream's clock.)
# clock_2:          axi-lite.
# clock_3~clock_6:  User define clock. Not set by default.
#****************************************************************
# Clock frequence, unit: MHz. Range [10, 400], integer.
export clk_freq=(100 150 50)

# Resource config.
#****************************************************************

# DMA config.
#****************************************************************
# !!! Very first Version! Haven't support lots of functions !!! #

# If use AXI DMA, 0 or 1.
export use_adma=0
export adma_ps_port="hp0"
# AXI DMA mode, "block" or "scatter_gather". Only support block now.     
export adma_mode="block"
# AXI dma direction, "read", "write" or "dual".
export adma_dir="dual"
# AXI DMA addr width, 32 or 64.
export adma_aw=32
# AXI DMA memory map data width, equal axi_hp_port_dw.          
export adma_mm_dw=64
# AXI DMA stream data width, 8, 16, 32, 64, 128, 256, 512, 1024.
# Must less or equal than $axi_dma_mm_dw !!!! Check board/your_board for more information.
export adma_s_dw=32

# User defined axil port. For user's ip.
#****************************************************************
export m_axil_user_num=0

# PL push button.
export use_pl_btn=0
# vga
export use_vga=0
# PL clock
export use_pl_clk=0
# vdma
export use_vdma=0


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
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************

# Vivado settings.
#****************************************************************
# Vivado path.
export VIVADO="vivado"
# If use gui.
export GUI_MODE=0
# Board name.
export board_name="zedboard"
# Project name.
export project_name="zynq_test"

# Resource config.
#****************************************************************

# DMA config.
#****************************************************************
# !!! Very first Version! Haven't support lots of functions !!! #

# AXI DMA config.
#****************************************************************
# If use AXI DMA, 0 or 1.
export use_axi_dma=1
# AXI DMA mode, "block" or "scatter_gather". Only support block now.     
export axi_dma_mode="block"
# AXI dma direction, "read", "write" or "dual".
export axi_dma_dir="read"
# AXI DMA addr width, 32 or 64.
export axi_dma_aw=32
# AXI DMA memory map data width, equal axi_hp_port_dw.          
export axi_dma_mm_dw=64
# AXI DMA stream data width, 8, 16, 32, 64, 128, 256, 512, 1024.
# Must less or equal than $axi_dma_mm_dw !!!! Check board/your_board for more information.
export axi_dma_s_dw=64
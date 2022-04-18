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
export GUI_MODE=1
# Board name.
export board_name="zedboard"
# Project name.
export project_name="zynq_test"

# Resource config.
#****************************************************************

# Zynq processing system config.
#****************************************************************
# Zynq AXI general purpose slave port config.
export axi_gp_port_num=1        # AXI general purpose slave port number, range[0, 2].
# Zynq AXI high performance slave port config.
export axi_hp_port_num=1        # AXI high performance slave port number, range[0, 4].
export axi_hp_port_dw=64        # AXI high performance slave port data width, 32 or 64.

# DMA config.
#****************************************************************
# !!! Very first Version! Haven't support lots of functions !!! #

# AXI DMA config.
#****************************************************************
# AXI DMA number, range[0, 2].
export axi_dma_num=2               
# AXI DMA mode, "block" or "scatter_gather". Only support block now.     
export axi_dma_mode=("block" "block")
# AXI dma direction, "read", "write" or "dual".
export axi_dma_dir=("read" "dual")
# AXI DMA addr width, 32 or 64.
export axi_dma_aw=(32 32)
# AXI DMA memory map data width, equal axi_hp_port_dw.          
export axi_dma_mm_dw=$axi_hp_port_dw
# AXI DMA stream data width, 8, 16, 32, 64, 128, 256, 512, 1024. (Must less or equal than $axi_dma_mm_dw !!!!)
export axi_dma_s_dw=(64 64)
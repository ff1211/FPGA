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
# Project name.
export project_name="zynq_test"

# Shell config.
#****************************************************************
# Board name.
export board_name="zedboard"
# Preset platform.
export preset_plat="image_plat"

# Clock config.
# Max 7 clock.
# clock_0:          axi-mm gp port.
# clock_1:          axi-mm hp port. (If use dma, it is also dma's axi-stream's clock.)
# clock_2:          axi-lite.
# clock_3~clock_6:  User define clock. Not set by default.
#****************************************************************
# Clock frequence, unit: MHz. Range [10, 400].
export clk_freq=(100 150 50 25.175)

# Resource config.
#****************************************************************

# DMA config.
#****************************************************************
# !!! Very first Version! Haven't support lots of functions !!! #

# User defined axil port. For user's ip.
#****************************************************************
export m_axil_user_num=0

# PL push button.
export use_pl_btn=1
# vga
export use_vga=1
# PL clock
export use_pl_clk=0
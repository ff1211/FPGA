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
export gui_mode=0
# Board name.
export board_name="zedboard"
# Project name.
export project_name="image_proc"

# Shell config.
#****************************************************************
# Preset platform.
export preset_plat="image_plat"

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
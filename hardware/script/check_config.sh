#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# check_config.sh
# 
# Description:
# Used for check config.sh's correctness.
# Work flow:
# First: Check basic config, such as vivado path and board name.
# Second: Check IP config.
#       1. check_hard_core() core_name      #--Optional, only for hard core config, such as hdmi or camera.
#
#       2. check_config_integrity() config_name
#       3. check_config_legal() config_name
#       4. Self-defined advanced check.
#
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************

# Check functions.
#****************************************************************
# Function to check if board have corresponding hardware resource.
# 1st parameter: hard core name.
# Example: check_hard_core hdmi.
check_hard_core(){
    name="have_$1"
    if [[ ${!name} -ne 1 ]]; then
        echo "$board_name doesn't have $1 resource!"
        error
    fi
}

# Function to check integrity of config.
# Example: check_integrity $basic_config.
check_config_integrity(){
    arr=("$@")
    for item in "${arr[@]}"; do
    if [[ ${!item} == "" ]]; then
        echo "Basic config incomplete! Missing: $item!"
        error
    fi
    done
}
# Function to check if config's items legal.
# 1st parameter: Config name.
# Example: check_config_legal $basic_config
check_config_legal(){
    arr=("$@")
    for config in "${arr[@]}"; do
        if_match=0
        sl_name="${config}_l[@]"
        arr2=("${!sl_name}")
        for item in "${arr2[@]}"; do
            if [[ ${!config} == "$item" ]]; then if_match=1; fi
        done
        if [[ $if_match -ne 1 ]]; then
            echo " $config's setting is illegal!"
            exit 1
        fi
    done
}

# Export IP list. Used by add_ip.sh to add ip and ip wrappers to project.
export ip_list=()

# Configs and setting lists.
#****************************************************************
# Basic config.
#----------------------------------------------------------------
basic_config=("vivado" "gui_mode" "board_name" "project_name" "preset_plat")
clock_config=("clk_freq")

# Soft core config.
#----------------------------------------------------------------
# Supported soft cores list.
# AXI DMA config.
axi_dma_config=("use_axi_dma" "axi_dma_mode" "axi_dma_dir" "axi_dma_aw" "axi_dma_mm_dw" "axi_dma_s_dw")
use_axi_dma_l=(0 1)
axi_dma_mode_l=("block" "scatter_gather")
axi_dma_dir_l=("read" "write" "dual")
axi_dma_aw_l=(32 64)
axi_dma_mm_dw_l=(32 64)
axi_dma_s_dw_l=(8 16 32 64 128 256 512 1024)

# Hard core config.
# Supported hard cores list.
#----------------------------------------------------------------


# Basic config check.
#****************************************************************

# Basic check.
check_config_integrity "${basic_config[@]}"

# Advanced check.
# Check if vivado directory is correct.
type -t "$vivado" > /dev/null
if [[ $? == 1 ]]; then
    echo "Vivado path false!"
    echo
    error
fi

# Check if have selected board.
no_board=1
for boards in "$BOARDS_DIR"/*; do
    if [ "$(basename "$boards")" == "$board_name" ]; then
        no_board=0
    fi
done

# If can not find board, print boards supported.
if [[ $no_board -eq 1 ]]; then
    echo "Haven't find this board!"
    echo "Check $BOARDS_DIR for supported boards!"
    echo
    error
fi

# Check if have selected platform preset.
no_preset=1
for presets in "$BOARDS_DIR/$board_name"/*; do
    if [ "$(basename "$presets")" == "$preset_plat" ]; then
        no_preset=0
    fi
done
if [[ $no_preset -eq 1 ]]; then
    echo "Haven't find this platform preset!"
    echo "Check $BOARDS_DIR/$board_name for supported preset!"
    echo
    error
fi


# Basic check pass. Check board and platform preset.
#****************************************************************
source $BOARDS_DIR/$board_name/board.sh || (echo "Can't find board.sh! Check integrity of $BOARDS_DIR/$board_name" error)
source $BOARDS_DIR/$board_name/$preset_plat/resource.sh || (echo "Can't find resource.sh! Check integrity of $BOARDS_DIR/$board_name/$preset_plat" error)

# Clock config check.
#****************************************************************
# Basic check.
check_config_integrity "${clock_config[@]}"
# Advanced check.

# AXI DMA config check.
#****************************************************************
if [[ $use_axi_dma -eq 1 ]]; then
    # Check if platform preset support AXI DMA.
    if [[ $have_axi_dma -ne 1 ]]; then
        echo "$board_name's $preset_plat preset doesn't support AXI DMA!"
        error
    fi
    # Basic check.
    check_config_integrity "${axi_dma_config[@]}"
    check_config_legal "${axi_dma_config[@]}"
    # Advanced check.
    if [[ $axi_dma_s_dw -gt $axi_dma_mm_dw ]]; then
        echo "AXI DMA axi-stream data width must no larger than AXI DMA axi-memory-map data width!!!!"
        error
    fi
    if [[ $axi_dma_mode == "scatter_gather" ]]; then
        echo "Error! We haven't support sg mode now!"
        error
    fi
fi
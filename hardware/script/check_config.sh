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
# 1.0      2022.04.14  ff          Initial version
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
# 1st parameter: Config number. For using multiple identical core. If doesn't have multiple configration, use "".
# Such as using three vdma and each has its own configration.
# Other parameter: Config list.
# Example:  
# check_integrity "" "$basic_config"
# check_integrity 0 "$vdma_config"
# check_integrity 1 "$vdma_config"
check_config_integrity(){
    num=$1
    shift
    arr=("$@")
    for item in "${arr[@]}"; do
        name="${item}${num}"
        if [[ ${!name} == "" ]]; then
            echo "Basic config incomplete! Missing: $name!"
            error
        fi
    done
}
# Function to check if config's items legal.
# 1st parameter: Config number. For using multiple identical core. If doesn't have multiple configration, use "".
# Such as using three vdma and each has its own configration.
# Other parameter: Config list.
# Example:  
# check_integrity_legal "" "$basic_config"
# check_integrity_legal 0 "$vdma_config"
# check_integrity_legal 1 "$vdma_config"
check_config_legal(){
    num=$1
    shift
    arr=("$@")
    for config in "${arr[@]}"; do
        name="${config}${num}"
        if_match=0
        sl_name="${config}_l[@]"
        arr2=("${!sl_name}")
        for item in "${arr2[@]}"; do
            if [[ ${!name} == "$item" ]]; then if_match=1; fi
        done
        if [[ $if_match -ne 1 ]]; then
            echo " $name's setting is illegal!"
            exit 1
        fi
    done
}
# # Function to assign ps slave ports.
# # 1st parameter: Port's name. ("hp0" "hp1" "hp2" "hp3" "acp" "ace" "hpc0" "hpc1")
# # 2st parameter: Number.
# # Example:  
# # assign_ps_slave "hp0" 4
# # assign_ps_slave "gp0" 4
# assign_ps_slave(){
#     if [[ $1 == "hp0" ]]; then
#         export s_axi_hp0_num=$((s_axi_hp0_num+$2))
#     elif [[ $1 == "hp1" ]]; then
#         export s_axi_hp1_num=$((s_axi_hp1_num+$2))
#     elif [[ $1 == "hp2" ]]; then
#         export s_axi_hp2_num=$((s_axi_hp2_num+$2))
#     elif [[ $1 == "hp3" ]]; then
#         export s_axi_hp3_num=$((s_axi_hp3_num+$2))
#     elif [[ $1 == "acp" ]]; then
#         export s_axi_acp_num=$((s_axi_acp_num+$2))
#     elif [[ $1 == "ace" ]]; then
#         export s_axi_ace_num=$((s_axi_ace_num+$2))
#     elif [[ $1 == "hpc0" ]]; then
#         export s_axi_hpc0_num=$((s_axi_hpc0_num+$2))
#     elif [[ $1 == "hpc1" ]]; then
#         export s_axi_hpc1_num=$((s_axi_hpc1_num+$2))
#     fi
# }

add_num_2sn() {
    sum=$(($2+$3))
    if [[ $sum -lt 10 ]]; then
        export $1="0$sum"
    else
        export $1="$sum"
    fi
}

# Configs and setting lists.
#****************************************************************
# Basic config.
#----------------------------------------------------------------
basic_config=("vivado" "gui_mode" "board_name" "project_name" "preset_plat")
clock_config=("clk_freq")

# Variables for calculating resource useage.
#----------------------------------------------------------------
export ip_list=()                           # IP list. Used by add_ip.sh to add ip and ip wrappers to project.
export m_axi_gp0_num=$((1+m_axil_user_num)) # AXI general purpose master port 0 slave number.
export m_axi_gp1_num=0                      # AXI general purpose master port 1 slave number.
export s_axi_gp0_num=0                      # AXI general purpose slave port 0 master number.
export s_axi_gp0_num=0                      # AXI general purpose slave port 1 master number.
export s_axi_hp0_num=0                      # AXI high performance slave port 0 master number.
export s_axi_hp1_num=0                      # AXI high performance slave port 1 master number.
export s_axi_hp2_num=0                      # AXI high performance slave port 2 master number.
export s_axi_hp3_num=0                      # AXI high performance slave port 3 master number.
export m_axi_gp0_base_addr=0x42000000       # AXI general purpose master port 0 base address.
export m_axi_gp0_addr_range="64K"           # AXI general purpose master port 0 address range.

# Soft ip config.
#----------------------------------------------------------------
# Supported soft cores list.
# AXI DMA config.
adma_config=("use_adma" "adma_ps_port" "adma_mode" "adma_dir" "adma_aw" "adma_mm_dw" "adma_s_dw")
use_adma_l=(0 1)
adma_ps_port_l=("hp0" "hp1" "hp2" "hp3" "acp" "ace" "hpc0" "hpc1")
adma_mode_l=("block" "scatter_gather")
adma_dir_l=("read" "write" "dual")
adma_aw_l=(32 64)
adma_mm_dw_l=(32 64)
adma_s_dw_l=(8 16 32 64 128 256 512 1024)
# VDMA config.
vdma_config=("use_vdma" "zynq_slave_port" "vdma_num" "vdma_dir" "vdma_w_fsync" "vdma_r_fsync" "vdma_aw" "vdma_mm_dw" "vdma_s_dw" "vdma_w_buffer_dep" "vdma_r_buffer_dep")
use_vdma_l=(0 1)
vdma_ps_port_l=("hp0" "hp1" "hp2" "hp3" "acp" "ace" "hpc0" "hpc1")
vdma_num_l=(1 2 3 4)
vdma_dir_l=("read" "write" "dual")
vdma_w_fsync_l=("none" "fsync" "tuser")
vdma_r_fsync_l=("none" "fsync")
vdma_aw_l=(32 64)
vdma_mm_dw_l=(32 64)
vdma_s_dw_l=(8 16 24 32 40 48 56 64 72 80 88 96 104 112 120 128 136 144 152 160 168 \
176 184 192 200 208 216 224 232 240 248 256 264 272 280 288 296 304 312 320 328 336 \
344 352 360 368 376 384 392 400 408 416 424 432 440 448 456 464 472 480 488 496 504 \
512 520 528 536 544 552 560 568 576 584 592 600 608 616 624 632 640 648 656 664 672 \
680 688 696 704 712 720 728 736 744 752 760 768 776 784 792 800 808 816 824 832 840 \
848 856 864 872 880 888 896 904 912 920 928 936 944 952 960 968 976 984 992 1000 1008 1016)
vdma_w_buffer_dep_l=(128 256 512 1024 2048 4096 8192 16384)
vdma_r_buffer_dep_l=(128 256 512 1024 2048 4096 8192 16384)

# Hard ip config.
# Supported hard cores list.
#----------------------------------------------------------------

# Basic config check.
#****************************************************************
# Basic check.
check_config_integrity "" "${basic_config[@]}"

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

# Basic check pass. Check board and platform preset's integrity.
#****************************************************************
source "$BOARDS_DIR/$board_name/board.sh" || (echo "Can't find board.sh! Check integrity of $BOARDS_DIR/$board_name" error)
source "$BOARDS_DIR/$board_name/$preset_plat/resource.sh" || (echo "Can't find resource.sh! Check integrity of $BOARDS_DIR/$board_name/$preset_plat" error)

# Board and platform preset's integrity check pass. Check clock and axi lite config.
#****************************************************************
# Clock config check.
#----------------------------------------------------------------
# Basic check.
check_config_integrity "" "${clock_config[@]}"
# Advanced check.


# AXI lite check.
#----------------------------------------------------------------
# Basic check.
export m_axil_num=$(($m_axil_num+$m_axil_user_num))
# Advanced check.

# Clock and axi lite check pass. Check soft ip.
#****************************************************************
# AXI DMA config check.
#----------------------------------------------------------------
if [[ $use_adma -eq 1 ]]; then
    # Basic check.
    # Check if platform preset support AXI DMA.
    if [[ $have_adma -ne 1 ]]; then
        echo "$board_name's $preset_plat preset doesn't support AXI DMA!"
        error
    fi
    check_config_integrity "" "${adma_config[@]}"
    check_config_legal "" "${adma_config[@]}"
    
    # Advanced check.
    if [[ $adma_s_dw -gt $adma_mm_dw ]]; then
        echo "AXI DMA axi-stream data width must no larger than AXI DMA axi-memory-map data width!!!!"
        error
    fi
    if [[ $adma_mode == "scatter_gather" ]]; then
        echo "Error! We haven't support sg mode now!"
        error
    fi
    # Export port useage.
    export m_axi_gp0_num=$((m_axi_gp0_num+1))
    if [[ $adma_dir == "dual" ]]; then
        adma_ps_port_use=2
    else
        adma_ps_port_use=1
    fi
    port="s_axi_${adma_ps_port}_num"
    export $port=$((${!port}+$adma_ps_port_use))
fi
# VDMA config check.
#----------------------------------------------------------------
# Basic check.
if [[ $use_vdma -eq 1 ]]; then
    # Basic check.
    # Check if platform preset support Video DMA.
    if [[ $have_vdma -ne 1 ]]; then
        echo "$board_name's $preset_plat preset doesn't support Video DMA!"
        error
    fi
    i=0
    while [[ $i -ne $vdma_num ]]; do
        check_config_integrity $i "${vdma_config[@]}"
        check_config_legal $i "${vdma_config[@]}"
        i=$((i+1))
    done
fi
# AXI check.
#****************************************************************
# AXI lite master check.
if [[ $m_axil_num -gt 8 ]]; then
    echo "Too much axi lite master port! Check your config!"
    error
fi
# AXI gp master check.
if [[ $m_axi_gp_num -gt 2 ]]; then
    echo "Too much axi gp master port! Check your config!"
    error
fi
# AXI gp slave check.
if [[ $m_axi_gp_num -gt 2 ]]; then
    echo "Too much axi gp slave port! Check your config!"
    error
fi
# AXI hp slave check.
if [[ $m_axi_gp_num -gt 4 ]]; then
    echo "Too much axi hp slave port! Check your config!"
    error
fi
#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# path.sh
# 
# Description:
# Define path used to create project.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  ff          Initial version
#****************************************************************

# Project directory.
PROJECT_DIR=$projec_dir
# Hardware directory.
cd ../
HARDWARE_DIR=$(pwd)
cd $PROJECT_DIR
# Script directory.
SCRIPT_DIR=$HARDWARE_DIR/script
# Board file directory.
BOARDS_DIR=$HARDWARE_DIR/board
# Shell directory.
SHELL_DIR=$HARDWARE_DIR/shell
# Shell common modules directory.
COMMON_DIR=$HARDWARE_DIR/shell/common
# Board preset directory.
PRESET_DIR=$BOARDS_DIR/$board_name/$preset_plat

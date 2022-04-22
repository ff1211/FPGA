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
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************

# Project directory.
export PROJECT_DIR=$projec_temp_dir/$project_temp_name
# Hardware directory.
cd ../
HARDWARE_DIR=$(pwd)
export HARDWARE_DIR
cd "$TEMPLATE_DIR" || (echo "cd fail!" exit 1)
# Script directory.
export SCRIPT_DIR=$HARDWARE_DIR/script
# Board file directory.
export BOARDS_DIR=$HARDWARE_DIR/board
# Shell directory.
export SHELL_DIR=$HARDWARE_DIR/shell
# Shell common modules directory.
export COMMON_DIR=$HARDWARE_DIR/shell/common
# Interface directory.
export INTERFACE_DIR=$HARDWARE_DIR/shell/interface


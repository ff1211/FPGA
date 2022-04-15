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

# Template directory.
export TEMPLATE_DIR=$(pwd)
# Hardware directory.
cd ../../
export HARDWARE_DIR=$(pwd)
cd $TEMPLATE_DIR
# Script directory.
export SCRIPT_DIR=$HARDWARE_DIR/script
# Board file directory.
export BOARDS_DIR=$HARDWARE_DIR/board
# Shell common modules directory.
export COMMON_DIR=$HARDWARE_DIR/shell/common
# Interface directory.
export INTERFACE_DIR=$HARDWARE_DIR/shell/interface

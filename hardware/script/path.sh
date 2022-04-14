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

# Current directory.
export CURRENT_DIR=$(pwd)/../..
# Project directory.
export PROJECT_DIR=$(pwd)
# Script directory.
export SCRIPT_DIR=$CURRENT_DIR/script
# Board file directory.
export BOARDS_DIR=$CURRENT_DIR/board
# Shell common modules directory.
export COMMON_DIR=$CURRENT_DIR/shell/common
# Interface directory.
export INTERFACE_DIR=$CURRENT_DIR/shell/interface

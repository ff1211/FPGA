#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# board.sh
# 
# Description:
# Bash shell for board define.
# Used for project creation.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************

# Board basic informations.
#****************************************************************
# Board name.
export board="ZedBoard"
# Chip name.
export chip="xc7z020"
# Package.
export package="clg484"
# Speed grade.
export speed_grade="-1"
# Prcessing system address width. 32 for Zynq-7000, 64 for Zynq-UltraScale.
export ps_addrw=32

# Board resource informations.
#****************************************************************
# Pmod.
export pmod_num=4

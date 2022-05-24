#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# specific_ip.sh
# 
# Description:
# Board preset specific ips.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.05.24  ff          Initial version
#****************************************************************

# Add pl btn
if [[ $use_pl_btn -eq 1 ]]; then 
    add_define "USE_PL_BTN"
    add_ip_wrapper "$PRESET_DIR/xdc/btn.xdc"
fi
# Add vga
if [[ $use_vga -eq 1 ]]; then
    add_define "USE_VGA" 
    add_ip_wrapper "$PRESET_DIR/xdc/vga.xdc"
fi
#!/bin/bash
#****************************************************************
# Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
#
# File:
# project.sh
# 
# Description:
# Bash shell for project genation.
# 
# Revision history:
# Version  Date        Author      Changes      
# 1.0      2022.04.14  Fanfei      Initial version
#****************************************************************

source ../../script/path.sh
source ./config.sh

echo

# Check the correctness of config.sh.
#****************************************************************
# Check if vivado directory is correct.
type -t $VIVADO > /dev/null
if [ $? == 1 ]; then
    echo "Vivado path false!"
    echo
    exit 1
fi

# Check if have selected board.
no_board=1
for boards in "$BOARDS_DIR"/*; do
    if [ "$(basename "$boards")" == $board_name ]; then
        no_board=0
    fi
done

if [ $no_board -eq 1 ]; then
    echo "Haven't find this board!"
    echo "We only support:"
    i=0
    for boards in "$BOARDS_DIR"/*
    do 
        echo -n "[`expr $i + 1`]"
        board_list[$i]="$(basename "$boards")"
        echo -n "$(basename "$boards") "
        i=`expr $i + 1`
    done
    echo
    echo
    exit 1
fi

# Start creating project
#****************************************************************
echo "Creating new project..."
# Creat Project folder.
i=0
if [[ -d $PROJECT_DIR/$project_name ]]; then

    while [[ -d $PROJECT_DIR/$project_name/${project_name}_$i && $i -lt 50 ]]; do
        i=`expr $i + 1`
    done
    if [ $i -eq 49 ]; then
        echo "Too much project! Create project fail!"
        exit 1
    fi
else
    mkdir "$PROJECT_DIR/$project_name"
fi
mkdir "$PROJECT_DIR/$project_name/${project_name}_$i"

export project_dir="$PROJECT_DIR/$project_name"
export current_project_dir="$PROJECT_DIR/$project_name/${project_name}_$i"

# Generate project.tcl for creating project in vivado.


#create_project tcl_test /home/ff/vivado/tcl_test -part xc7vx485tffg1157-1
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
source $BOARDS_DIR/$board_name/board.sh
# Creat Project folder.
i=0
if [[ -d $TEMPLATE_DIR/$project_name ]]; then

    while [[ -d $TEMPLATE_DIR/$project_name/${project_name}_$i && $i -lt 50 ]]; do
        i=`expr $i + 1`
    done
    if [ $i -eq 49 ]; then
        echo "Too much project! Create project fail!"
        exit 1
    fi
else
    mkdir "$TEMPLATE_DIR/$project_name"
fi
mkdir "$TEMPLATE_DIR/$project_name/${project_name}_$i"

project_set_dir="$TEMPLATE_DIR/$project_name"
cur_project_dir="$TEMPLATE_DIR/$project_name/${project_name}_$i"
cur_project_name="${project_name}_$i"

# Set project mode.
vivado_mode="tcl"
[[ $GUI_MODE -eq 1 ]] && vivado_mode="gui"

# Generate project.tcl for creating project in vivado.
touch $project_set_dir/project.tcl
cat > $project_set_dir/project.tcl << EOF
#****************************************************************
# This is a auto-generated file. Do not change it!
#****************************************************************

# Set directorys.
#****************************************************************
set TEMPLATE_DIR $TEMPLATE_DIR
set HARDWARE_DIR $HARDWARE_DIR
set SCRIPT_DIR $SCRIPT_DIR
set BOARDS_DIR $BOARDS_DIR
set COMMON_DIR $COMMON_DIR
set INTERFACE_DIR $INTERFACE_DIR

# Creat project.
#****************************************************************
create_project -part ${chip}${package}${speed_grade} ${cur_project_name} ${cur_project_dir}

# Add common files.
#****************************************************************
source ${HARDWARE_DIR}/script/add_files.tcl

# Add board and project specific files.
#****************************************************************
add_files $BOARDS_DIR/$board_name/shell_top.sv $TEMPLATE_DIR/role.sv
EOF

# Move to project directory and launch vivado.
cd $cur_project_dir
$VIVADO -mode ${vivado_mode} -source $project_set_dir/project.tcl
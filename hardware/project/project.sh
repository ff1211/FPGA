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

# Error Function.
error(){
    echo "ERROR! Project creation fail!"
    echo
    exit 1
}

# Check if set project template.
if [[ $1 == "" ]]; then
    echo "Haven't set project template name!"
    error
fi
export preset_name=$1
export projec_dir=$(pwd)
source $projec_dir/../script/path.sh
source $projec_dir/config.sh

echo

# Check the correctness of config.sh.
#****************************************************************
source $SCRIPT_DIR/check_config.sh

# Start creating project
#****************************************************************
echo "Creating new project..."

# Creat Project folder.
i=0
if [[ -d $PROJECT_DIR/$project_name ]]; then

    while [[ -d $PROJECT_DIR/$project_name/${project_name}_$i && $i -lt 50 ]]; do
        i=$((i+1))
    done
    if [ $i -eq 49 ]; then
        echo "Too much project existed! Create project fail!"
        error
    fi
else
    mkdir "$PROJECT_DIR/$project_name"
fi
mkdir "$PROJECT_DIR/$project_name/${project_name}_$i"

pj_set_dir="$PROJECT_DIR/$project_name"
cur_pj_dir="$PROJECT_DIR/$project_name/${project_name}_$i"
cur_pj_name="${project_name}_$i"

mkdir "$cur_pj_dir/src"
mkdir "$cur_pj_dir/script"
cur_pj_src_dir="$cur_pj_dir/src"
cur_pj_script_dir="$cur_pj_dir/script"

# Copy shell_top.sv and role.sv to current project dir.
cp $BOARDS_DIR/$board_name/$preset_plat/shell_top.sv $cur_pj_src_dir
cp $BOARDS_DIR/$board_name/$preset_plat/role.sv $cur_pj_src_dir

# Generate add_ip.tcl for add ips.
touch "$cur_pj_script_dir/add_ip.tcl"
export add_ip_tcl_path=$cur_pj_script_dir/add_ip.tcl
cat > "$cur_pj_script_dir/add_ip.tcl" << EOF
#****************************************************************
# This is a auto-generated file. Do not change it!
#****************************************************************
EOF

# Generate pre_proc.vh for config ips.
touch "$cur_pj_src_dir/pre_proc.vh"
export pre_proc_path="$cur_pj_src_dir/pre_proc.vh"
cat > "$cur_pj_src_dir/pre_proc.vh" << EOF
//****************************************************************
// This is a auto-generated file. Do not change it!
//****************************************************************
\`ifndef PRE_PROC
\`define PRE_PROC
EOF

# Source add_ip.sh to generate add_ip.tcl.
source $SCRIPT_DIR/add_ip.sh

# Generate project.tcl for creating project in vivado.
touch $cur_pj_dir/project.tcl
cat > $cur_pj_dir/project.tcl << EOF
#****************************************************************
# This is a auto-generated file. Do not change it!
#****************************************************************

# Set directorys.
#****************************************************************
set PROJECT_DIR $PROJECT_DIR
set HARDWARE_DIR $HARDWARE_DIR
set SCRIPT_DIR $SCRIPT_DIR
set BOARDS_DIR $BOARDS_DIR
set COMMON_DIR $COMMON_DIR

# Creat project.
#****************************************************************
create_project -part ${chip}${package}${speed_grade} ${cur_pj_name} ${cur_pj_dir}

# Add common files.
source ${HARDWARE_DIR}/script/add_files.tcl

# Add ips.
source ${cur_pj_script_dir}/add_ip.tcl

# Add board and project specific files.
#****************************************************************
add_files \\
    $BOARDS_DIR/$board_name/$preset_plat/shell_top.sv \\
    $BOARDS_DIR/$board_name/$preset_plat/role.sv \\
    $cur_pj_src_dir/pre_proc.vh
EOF
# $cur_pj_src_dir/shell_top.sv \\
# $cur_pj_src_dir/role.sv \\
# $BOARDS_DIR/$board_name/$preset_plat/shell_top.sv \\
# $PROJECT_DIR/role.sv \\

[[ $gui_mode -eq 1 ]] && echo "start_gui" >> "$cur_pj_dir/project.tcl"

# Move to project directory and launch vivado.
cd $cur_pj_dir || (echo "cd to current project's directory fail!"; error)
$vivado -mode tcl -source $cur_pj_dir/project.tcl
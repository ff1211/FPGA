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

if [ $no_board == 1 ]; then
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

echo "Creating new project..."


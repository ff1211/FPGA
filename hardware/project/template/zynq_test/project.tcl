#****************************************************************
# This is a auto-generated file. Do not change it!
#****************************************************************

# Set directorys.
#****************************************************************
set TEMPLATE_DIR /home/ff/git/FPGA/hardware/project/template
set HARDWARE_DIR /home/ff/git/FPGA/hardware
set SCRIPT_DIR /home/ff/git/FPGA/hardware/script
set BOARDS_DIR /home/ff/git/FPGA/hardware/board
set COMMON_DIR /home/ff/git/FPGA/hardware/shell/common
set INTERFACE_DIR /home/ff/git/FPGA/hardware/shell/interface

# Creat project.
#****************************************************************
create_project -part xc7z020clg484-1 zynq_test_0 /home/ff/git/FPGA/hardware/project/template/zynq_test/zynq_test_0

# Add common files.
#****************************************************************
source /home/ff/git/FPGA/hardware/script/add_files.tcl

# Add board and project specific files.
#****************************************************************
add_files /home/ff/git/FPGA/hardware/board/zedboard/shell_top.sv /home/ff/git/FPGA/hardware/project/template/role.sv

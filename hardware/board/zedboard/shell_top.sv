//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// shell_top.sv
// 
// Description:
// Top module of zedboard.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.14  Fanfei      Initial version
//****************************************************************

module shell_top #(
    
) (
    // Fixed IO.
    inout           FIXED_IO_ddr_vrn,
    inout           FIXED_IO_ddr_vrp,
    inout [53:0]    FIXED_IO_mio,
    inout           FIXED_IO_ps_clk,
    inout           FIXED_IO_ps_porb,
    inout           FIXED_IO_ps_srstb,
    // DDR ports.
    inout [14:0]    DDR_addr,
    inout [2:0]     DDR_ba,
    inout           DDR_cas_n,
    inout           DDR_ck_n,
    inout           DDR_ck_p,
    inout           DDR_cke,
    inout           DDR_cs_n,
    inout [3:0]     DDR_dm,
    inout [31:0]    DDR_dq,
    inout [3:0]     DDR_dqs_n,
    inout [3:0]     DDR_dqs_p,
    inout           DDR_odt,
    inout           DDR_ras_n,
    inout           DDR_reset_n,
    inout           DDR_we_n
);
    
endmodule
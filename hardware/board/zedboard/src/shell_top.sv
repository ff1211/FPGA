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

`include "config.vh"

module shell_top (
    // Fixed IO.
    inout           fixed_io_ddr_vrn,
    inout           fixed_io_ddr_vrp,
    inout [53:0]    fixed_io_mio,
    inout           fixed_io_ps_clk,
    inout           fixed_io_ps_porb,
    inout           fixed_io_ps_srstb,
    // DDR ports.
    inout [14:0]    ddr_addr,
    inout [2:0]     ddr_ba,
    inout           ddr_cas_n,
    inout           ddr_ck_n,
    inout           ddr_ck_p,
    inout           ddr_cke,
    inout           ddr_cs_n,
    inout [3:0]     ddr_dm,
    inout [31:0]    ddr_dq,
    inout [3:0]     ddr_dqs_n,
    inout [3:0]     ddr_dqs_p,
    inout           ddr_odt,
    inout           ddr_ras_n,
    inout           ddr_reset_n,
    inout           ddr_we_n
);

// Processing system AXI general slave port config.
`ifdef USE_AXI_GP

`endif

// Processing system AXI high profermance slave port config.
`ifdef USE_AXI_HP

`endif

ps #(

) processing_sys_inst (
    .fixed_io_ddr_vrn   (   fixed_io_ddr_vrn    ),
    .fixed_io_ddr_vrp   (   fixed_io_ddr_vrp    ),
    .fixed_io_mio       (   fixed_io_mio        ),
    .fixed_io_ps_clk    (   fixed_io_ps_clk     ),
    .fixed_io_ps_porb   (   fixed_io_ps_porb    ),
    .fixed_io_ps_srstb  (   fixed_io_ps_srstb   ),
    .ddr_addr           (   ddr_addr            ),
    .ddr_ba             (   ddr_ba              ),
    .ddr_cas_n          (   ddr_cas_n           ),
    .ddr_ck_n           (   ddr_ck_n            ),
    .ddr_ck_p           (   ddr_ck_p            ),
    .ddr_cke            (   ddr_cke             ),
    .ddr_cs_n           (   ddr_cs_n            ),
    .ddr_dm             (   ddr_dm              ),
    .ddr_dq             (   ddr_dq              ),
    .ddr_dqs_n          (   ddr_dqs_n           ),
    .ddr_dqs_p          (   ddr_dqs_p           ),
    .ddr_odt            (   ddr_odt             ),
    .ddr_ras_n          (   ddr_ras_n           ),
    .ddr_reset_n        (   ddr_reset_n         ),
    .ddr_we_n           (   ddr_we_n            )
);
    
endmodule
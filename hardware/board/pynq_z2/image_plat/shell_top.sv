//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// shell_top.sv
// 
// Description:
// Top module of pynq_z2 image_plat preset.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.06.01  ff          Initial version
//****************************************************************

`include "pre_proc.vh"
`include "interconnect.vh"

module shell_top (
    `ifdef USE_PL_CLK
    input           pl_clk,
    `endif
    `ifdef USE_HDMI_O
    output          hdmi_o_clk_n,
    output          hdmi_o_clk_p,
    output [2:0]    hdmi_o_data_n,
    output [2:0]    hdmi_o_data_p,
    `endif
    `ifdef USE_PL_BTN
    input  [3:0]    btn,
    `endif
    `ifdef USE_PL_LED
    output [3:0]    led,
    `endif
    // Fixed IO.
    inout           fixed_io_ddr_vrn,
    inout           fixed_io_ddr_vrp,
    inout  [53:0]   fixed_io_mio,
    inout           fixed_io_ps_clk,
    inout           fixed_io_ps_porb,
    inout           fixed_io_ps_srstb,
    // DDR ports.
    inout  [14:0]   ddr_addr,
    inout  [2:0]    ddr_ba,
    inout           ddr_cas_n,
    inout           ddr_ck_n,
    inout           ddr_ck_p,
    inout           ddr_cke,
    inout           ddr_cs_n,
    inout  [3:0]    ddr_dm,
    inout  [31:0]   ddr_dq,
    inout  [3:0]    ddr_dqs_n,
    inout  [3:0]    ddr_dqs_p,
    inout           ddr_odt,
    inout           ddr_ras_n,
    inout           ddr_reset_n,
    inout           ddr_we_n
);

logic [`SYS_CLK_NUM-1:0]    sys_clk;
logic [`SYS_CLK_NUM-1:0]    ic_rst_n;
logic [`SYS_CLK_NUM-1:0]    perif_rst_n;

axi_lite #(.CHANNEL(1), .DATA_WIDTH(32)) axil_check();
`ifdef USE_M_AXIL_USER axi_lite #(.CHANNEL(`M_AXIL_USER_NUM), .DATA_WIDTH(32)) axil_user(); `endif

sys #(
) sys_inst (
    .sys_clk            (   sys_clk             ),
    .ic_rst_n           (   ic_rst_n            ),
    .perif_rst_n        (   perif_rst_n         ),

    .fixed_io_ddr_vrn   (   fixed_io_ddr_vrn    ),
    .fixed_io_ddr_vrp   (   fixed_io_ddr_vrp    ),
    .fixed_io_mio       (   fixed_io_mio        ),
    .fixed_io_ps_clk    (   fixed_io_ps_clk     ),
    .fixed_io_ps_porb   (   fixed_io_ps_porb    ),
    .fixed_io_ps_srstb  (   fixed_io_ps_srstb   ),

    .m_axil_check       (   axil_check.master   ),

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

axil_dummy #(
    .MAGIC_NUM  (   'h00114514  )
) axil_dummy_inst (
    .s_axil     (   axil_check.slave    )
);

role #(

) role_inst (
    `ifdef USE_PL_CLK
    .pl_clk         (   pl_clk          ),
    `endif
    `ifdef USE_HDMI_O
    .hdmi_o_clk_n   (   hdmi_o_clk_n    ),
    .hdmi_o_clk_p   (   hdmi_o_clk_p    ),
    .hdmi_o_data_n  (   hdmi_o_data_n   ),
    .hdmi_o_data_p  (   hdmi_o_data_p   ),
    `endif
    `ifdef USE_PL_BTN
    .btn            (   btn             ),
    `endif
    `ifdef USE_PL_LED
    .led            (   led             ),
    `endif
    `ifdef USE_M_AXIL_USER
    .s_axil_user    (   axil_user.slave ),
    `endif    
    .pl_clk         (   pl_clk          ),
    .sys_clk        (   sys_clk         ),
    .ic_rst_n       (   ic_rst_n        ),
    .perif_rst_n    (   perif_rst_n     )
);

endmodule
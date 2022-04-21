//****************************************************************
// Copyright 2022 Tianjin University 305 Lab. All Rights Reserved.
//
// File:
// ps.sv
// 
// Description:
// Top module of processing system.
// 
// Revision history:
// Version  Date        Author      Changes      
// 1.0      2022.04.17  Fanfei      Initial version
//****************************************************************

module ps_7 #(

) (
    `ifdef USE_AXI_GP_PORT
    axi4            s_axi_gp,
    `endif
    `ifdef USE_AXI_HP_PORT_0
    axi4            s_axi_hp_0,
    `endif
    `ifdef USE_AXI_HP_PORT_1
    axi4            s_axi_hp_1,
    `endif
    `ifdef USE_AXI_HP_PORT_2
    axi4            s_axi_hp_2,
    `endif
    `ifdef USE_AXI_HP_PORT_3
    axi4            s_axi_hp_3,
    `endif
    input           m_axi_ap_clk,
    axi4            m_axi_gp,

    // Clock and reset.
    output          fclk,
    output          fclk_rst_n,
    
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

processing_system7_0 processing_system7_inst (
    .TTC0_WAVE0_OUT     (           ),            // output wire TTC0_WAVE0_OUT
    .TTC0_WAVE1_OUT     (           ),            // output wire TTC0_WAVE1_OUT
    .TTC0_WAVE2_OUT     (           ),            // output wire TTC0_WAVE2_OUT
    .USB0_PORT_INDCTL   (           ),        // output wire [1 : 0] USB0_PORT_INDCTL
    .USB0_VBUS_PWRSELECT(           ),  // output wire USB0_VBUS_PWRSELECT
    .USB0_VBUS_PWRFAULT (   1'b0    ),    // input wire USB0_VBUS_PWRFAULT
    .M_AXI_GP0_ARVALID  (   m_axi_gp.arvalid    ),      // output wire M_AXI_GP0_ARVALID
    .M_AXI_GP0_AWVALID  (   m_axi_gp.awvalid    ),      // output wire M_AXI_GP0_AWVALID
    .M_AXI_GP0_BREADY   (   m_axi_gp.bready     ),        // output wire M_AXI_GP0_BREADY
    .M_AXI_GP0_RREADY   (   m_axi_gp.rready     ),        // output wire M_AXI_GP0_RREADY
    .M_AXI_GP0_WLAST    (   m_axi_gp.wlast      ),          // output wire M_AXI_GP0_WLAST
    .M_AXI_GP0_WVALID   (   m_axi_gp.wvalid     ),        // output wire M_AXI_GP0_WVALID
    .M_AXI_GP0_ARID     (   m_axi_gp.arid       ),            // output wire [11 : 0] M_AXI_GP0_ARID
    .M_AXI_GP0_AWID     (   m_axi_gp.awid       ),            // output wire [11 : 0] M_AXI_GP0_AWID
    .M_AXI_GP0_WID      (   m_axi_gp.wid        ),              // output wire [11 : 0] M_AXI_GP0_WID
    .M_AXI_GP0_ARBURST  (   m_axi_gp.arburst    ),      // output wire [1 : 0] M_AXI_GP0_ARBURST
    .M_AXI_GP0_ARLOCK   (   m_axi_gp.arlock     ),        // output wire [1 : 0] M_AXI_GP0_ARLOCK
    .M_AXI_GP0_ARSIZE   (   m_axi_gp.arsize     ),        // output wire [2 : 0] M_AXI_GP0_ARSIZE
    .M_AXI_GP0_AWBURST  (   m_axi_gp.awburst    ),      // output wire [1 : 0] M_AXI_GP0_AWBURST
    .M_AXI_GP0_AWLOCK   (   m_axi_gp.awlock     ),        // output wire [1 : 0] M_AXI_GP0_AWLOCK
    .M_AXI_GP0_AWSIZE   (   m_axi_gp.awsize     ),        // output wire [2 : 0] M_AXI_GP0_AWSIZE
    .M_AXI_GP0_ARPROT   (   m_axi_gp.arprot     ),        // output wire [2 : 0] M_AXI_GP0_ARPROT
    .M_AXI_GP0_AWPROT   (   m_axi_gp.awprot     ),        // output wire [2 : 0] M_AXI_GP0_AWPROT
    .M_AXI_GP0_ARADDR   (   m_axi_gp.araddr     ),        // output wire [31 : 0] M_AXI_GP0_ARADDR
    .M_AXI_GP0_AWADDR   (   m_axi_gp.awaddr     ),        // output wire [31 : 0] M_AXI_GP0_AWADDR
    .M_AXI_GP0_WDATA    (   m_axi_gp.wdata      ),          // output wire [31 : 0] M_AXI_GP0_WDATA
    .M_AXI_GP0_ARCACHE  (   m_axi_gp.arcache    ),      // output wire [3 : 0] M_AXI_GP0_ARCACHE
    .M_AXI_GP0_ARLEN    (   m_axi_gp.arlen      ),          // output wire [3 : 0] M_AXI_GP0_ARLEN
    .M_AXI_GP0_ARQOS    (   m_axi_gp.arqos      ),          // output wire [3 : 0] M_AXI_GP0_ARQOS
    .M_AXI_GP0_AWCACHE  (   m_axi_gp.awcache    ),      // output wire [3 : 0] M_AXI_GP0_AWCACHE
    .M_AXI_GP0_AWLEN    (   m_axi_gp.awlen      ),          // output wire [3 : 0] M_AXI_GP0_AWLEN
    .M_AXI_GP0_AWQOS    (   m_axi_gp.awqos      ),          // output wire [3 : 0] M_AXI_GP0_AWQOS
    .M_AXI_GP0_WSTRB    (   m_axi_gp.wstrb      ),          // output wire [3 : 0] M_AXI_GP0_WSTRB
    .M_AXI_GP0_ACLK     (   m_axi_ap_clk        ),            // input wire M_AXI_GP0_ACLK
    .M_AXI_GP0_ARREADY  (   m_axi_gp.arready    ),      // input wire M_AXI_GP0_ARREADY
    .M_AXI_GP0_AWREADY  (   m_axi_gp.awready    ),      // input wire M_AXI_GP0_AWREADY
    .M_AXI_GP0_BVALID   (   m_axi_gp.bvalid     ),        // input wire M_AXI_GP0_BVALID
    .M_AXI_GP0_RLAST    (   m_axi_gp.rlast      ),          // input wire M_AXI_GP0_RLAST
    .M_AXI_GP0_RVALID   (   m_axi_gp.rvalid     ),        // input wire M_AXI_GP0_RVALID
    .M_AXI_GP0_WREADY   (   m_axi_gp.wready     ),        // input wire M_AXI_GP0_WREADY
    .M_AXI_GP0_BID      (   m_axi_gp.bid        ),              // input wire [11 : 0] M_AXI_GP0_BID
    .M_AXI_GP0_RID      (   m_axi_gp.rid        ),              // input wire [11 : 0] M_AXI_GP0_RID
    .M_AXI_GP0_BRESP    (   m_axi_gp.bresp      ),          // input wire [1 : 0] M_AXI_GP0_BRESP
    .M_AXI_GP0_RRESP    (   m_axi_gp.rresp      ),          // input wire [1 : 0] M_AXI_GP0_RRESP
    .M_AXI_GP0_RDATA    (   m_axi_gp.rdata      ),          // input wire [31 : 0] M_AXI_GP0_RDATA
    .FCLK_CLK0          (   fclk                ),         // output wire FCLK_CLK0
    .FCLK_RESET0_N      (   fclk_rst_n          ),         // output wire FCLK_RESET0_N
    .MIO                (   fixed_io_mio        ),        // inout wire [53 : 0] MIO
    .DDR_Addr           (   ddr_addr            ),                     // inout wire DDR_CAS_n
    .DDR_BankAddr       (   ddr_ba              ),                         // inout wire DDR_CKE
    .DDR_CAS_n          (   ddr_cas_n           ),                     // inout wire DDR_Clk_n
    .DDR_CKE            (   ddr_cke             ),                         // inout wire DDR_Clk
    .DDR_CS_n           (   ddr_cs_n            ),                       // inout wire DDR_CS_n
    .DDR_Clk            (   ddr_ck_p            ),                     // inout wire DDR_DRSTB
    .DDR_Clk_n          (   ddr_ck_n            ),                         // inout wire DDR_ODT
    .DDR_DM             (   ddr_dm              ),                     // inout wire DDR_RAS_n
    .DDR_DQ             (   ddr_dq              ),                          // inout wire DDR_WEB
    .DDR_DQS            (   ddr_dqs_p           ),               // inout wire [2 : 0] DDR_BankAddr
    .DDR_DQS_n          (   ddr_dqs_n           ),                       // inout wire [14 : 0] DDR_Addr
    .DDR_DRSTB          (   ddr_reset_n         ),                         // inout wire DDR_VRN
    .DDR_ODT            (   ddr_odt             ),                         // inout wire DDR_VRP
    .DDR_RAS_n          (   ddr_ras_n           ),             // inout wire [3 : 0] DDR_DM
    .DDR_VRN            (   fixed_io_ddr_vrn    ),             // inout wire [31 : 0] DDR_DQ
    .DDR_VRP            (   fixed_io_ddr_vrp    ),          // inout wire [3 : 0] DDR_DQS_n
    .DDR_WEB            (   ddr_we_n            ),            // inout wire [3 : 0] DDR_DQS
    .PS_SRSTB           (   fixed_io_ps_srstb   ),                        // inout wire PS_SRSTB
    .PS_CLK             (   fixed_io_ps_clk     ),                            // inout wire PS_CLK
    .PS_PORB            (   fixed_io_ps_porb    )                          // inout wire PS_PORB
);
    
endmodule
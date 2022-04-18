//****************************************************************
// This is a auto-generated file. Do not change it!
//****************************************************************

`timescale 1ns/1ps
module axi_dma(
    input       m_axi_clk,
    input       m_axil_clk,
    input       axi_rst_n,
    `ifdef USE_AXI_DMA_WRITE
    axis        s_axis_s2mm,
    output      mm2s_introut,
    `endif
    `ifdef USE_AXI_DMA_READ
    axis        m_axis_mm2s,
    output      mm2s_introut,
    `endif
    axi_lite    s_axil,
    axi4        m_axi
);
axi_dma_0 axi_dma_inst (
  .s_axi_lite_aclk          (   m_axil_clk      ),               
  .m_axi_mm2s_aclk          (   m_axi_clk       ),               
  .axi_resetn               (   axi_rst_n       ),                         
  .s_axi_lite_awvalid       (   s_axil.awvalid  ),         
  .s_axi_lite_awready       (   s_axil.awready  ),         
  .s_axi_lite_awaddr        (   s_axil.awaddr   ),           
  .s_axi_lite_wvalid        (   s_axil.wvalid   ),           
  .s_axi_lite_wready        (   s_axil.wready   ),           
  .s_axi_lite_wdata         (   s_axil.wdata    ),             
  .s_axi_lite_bresp         (   s_axil.bresp    ),             
  .s_axi_lite_bvalid        (   s_axil.bvalid   ),           
  .s_axi_lite_bready        (   s_axil.bready   ),           
  .s_axi_lite_arvalid       (   s_axil.arvalid  ),         
  .s_axi_lite_arready       (   s_axil.arready  ),         
  .s_axi_lite_araddr        (   s_axil.araddr   ),           
  .s_axi_lite_rvalid        (   s_axil.rvalid   ),           
  .s_axi_lite_rready        (   s_axil.rready   ),           
  .s_axi_lite_rdata         (   s_axil.rdata    ),             
  .s_axi_lite_rresp         (   s_axil.rresp    ),

  `ifdef USE_AXI_DMA_READ
  .m_axi_mm2s_araddr        (   m_axi.araddr    ),
  .m_axi_mm2s_arlen         (   m_axi.arlen     ),
  .m_axi_mm2s_arsize        (   m_axi.arsize    ),
  .m_axi_mm2s_arburst       (   m_axi.arburst   ),
  .m_axi_mm2s_arprot        (   m_axi.arprot    ),
  .m_axi_mm2s_arcache       (   m_axi.arcache   ),
  .m_axi_mm2s_arvalid       (   m_axi.arvalid   ),
  .m_axi_mm2s_arready       (   m_axi.arready   ),
  .m_axi_mm2s_rdata         (   m_axi.rdata     ),
  .m_axi_mm2s_rresp         (   m_axi.rresp     ),
  .m_axi_mm2s_rlast         (   m_axi.rlast     ),
  .m_axi_mm2s_rvalid        (   m_axi.rvalid    ),
  .m_axi_mm2s_rready        (   m_axi.rready    ),
  .mm2s_prmry_reset_out_n   (                   ),

  .m_axis_mm2s_tdata        (   m_axis_mm2s.tdata   ),
  .m_axis_mm2s_tkeep        (   m_axis_mm2s.tkeep   ),
  .m_axis_mm2s_tvalid       (   m_axis_mm2s.tvalid  ),
  .m_axis_mm2s_tready       (   m_axis_mm2s.tready  ),
  .m_axis_mm2s_tlast        (   m_axis_mm2s.tlast   ),
  .mm2s_introut             (   mm2s_introut        ),
  `endif

  `ifdef USE_AXI_DMA_WRITE
  .m_axi_s2mm_awaddr        (   m_axi.awaddr    ),          
  .m_axi_s2mm_awlen         (   m_axi.awlen     ),            
  .m_axi_s2mm_awsize        (   m_axi.awsize    ),          
  .m_axi_s2mm_awburst       (   m_axi.awburst   ),        
  .m_axi_s2mm_awprot        (   m_axi.awprot    ),          
  .m_axi_s2mm_awcache       (   m_axi.awcache   ),        
  .m_axi_s2mm_awvalid       (   m_axi.awvalid   ),        
  .m_axi_s2mm_awready       (   m_axi.awready   ),        
  .m_axi_s2mm_wdata         (   m_axi.wdata     ),            
  .m_axi_s2mm_wstrb         (   m_axi.wstrb     ),            
  .m_axi_s2mm_wlast         (   m_axi.wlast     ),            
  .m_axi_s2mm_wvalid        (   m_axi.wvalid    ),          
  .m_axi_s2mm_wready        (   m_axi.wready    ),          
  .m_axi_s2mm_bresp         (   m_axi.bresp     ),            
  .m_axi_s2mm_bvalid        (   m_axi.bvalid    ),          
  .m_axi_s2mm_bready        (   m_axi.bready    ),          
  .s2mm_prmry_reset_out_n   (                   ),

  .s_axis_s2mm_tdata        (   s_axis_s2mm.tdata   ),          
  .s_axis_s2mm_tkeep        (   s_axis_s2mm.tkeep   ),          
  .s_axis_s2mm_tvalid       (   s_axis_s2mm.tvalid  ),        
  .s_axis_s2mm_tready       (   s_axis_s2mm.tready  ),        
  .s_axis_s2mm_tlast        (   s_axis_s2mm.tlast   ),          
  .s2mm_introut             (   s2mm_introut        ),
  `endif
  .axi_dma_tstvec           (                       )   
);               
endmodule

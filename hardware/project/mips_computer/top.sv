`timescale 1ns/1ps

`include "axi_if.sv"

module top (
    input  logic        clk,
    input  logic        rst_n
);

localparam DATA_WIDTH       = 32;
localparam DATA_RAM_DEPTH   = 4096;
localparam INS_RAM_DEPTH    = 4096;

axi_lite #(.DATA_WIDTH(DATA_WIDTH))   core_data_if();
axi_lite #(.DATA_WIDTH(DATA_WIDTH))   core_ins_if();

mips_core mips_core_inst(
    .clk            (   clk     ),
    .rst_n          (   rst_n   ),
    .ins_if         (   core_ins_if     ),
    .data_if        (   core_data_if    )
);

logic                               ins_mem_clk;
logic                               ins_mem_rst;
logic [DATA_WIDTH/8-1:0]            ins_mem_en;
logic [DATA_WIDTH/8-1:0]            ins_mem_wr_en;
logic [DATA_WIDTH-1:0]              ins_mem_wrdata;
logic [DATA_WIDTH-1:0]              ins_mem_rddata;
logic [$clog2(DATA_RAM_DEPTH)-1:0]  ins_mem_addr;

logic                               data_mem_clk;
logic                               data_mem_rst;
logic [DATA_WIDTH/8-1:0]            data_mem_en;
logic [DATA_WIDTH/8-1:0]            data_mem_wr_en;
logic [DATA_WIDTH-1:0]              data_mem_wrdata;   
logic [DATA_WIDTH-1:0]              data_mem_rddata;  
logic [$clog2(DATA_RAM_DEPTH)-1:0]  data_mem_addr;

axi_bram_ctrl_0 instruction_ram_ctrl_inst (
    .s_axi_aclk       (   clk     ),                // input wire s_axi_aclk
    .s_axi_aresetn    (   rst_n   ),                // input wire s_axi_aresetn
    .s_axi_awaddr     (   core_ins_if.awaddr    ),  // input wire [13 : 0] s_axi_awaddr
    .s_axi_awprot     (   core_ins_if.awprot    ),  // input wire [2 : 0] s_axi_awprot
    .s_axi_awvalid    (   core_ins_if.awvalid   ),  // input wire s_axi_awvalid
    .s_axi_awready    (   core_ins_if.awready   ),  // output wire s_axi_awready
    .s_axi_wdata      (   core_ins_if.wdata     ),  // input wire [31 : 0] s_axi_wdata
    .s_axi_wstrb      (   core_ins_if.wstrb     ),  // input wire [3 : 0] s_axi_wstrb
    .s_axi_wvalid     (   core_ins_if.wvalid    ),  // input wire s_axi_wvalid
    .s_axi_wready     (   core_ins_if.wready    ),  // output wire s_axi_wready
    .s_axi_bresp      (   core_ins_if.bresp     ),  // output wire [1 : 0] s_axi_bresp
    .s_axi_bvalid     (   core_ins_if.bvalid    ),  // output wire s_axi_bvalid
    .s_axi_bready     (   core_ins_if.bready    ),  // input wire s_axi_bready
    .s_axi_araddr     (   core_ins_if.araddr    ),  // input wire [13 : 0] s_axi_araddr
    .s_axi_arprot     (   core_ins_if.arprot    ),  // input wire [2 : 0] s_axi_arprot
    .s_axi_arvalid    (   core_ins_if.arvalid   ),  // input wire s_axi_arvalid
    .s_axi_arready    (   core_ins_if.arready   ),  // output wire s_axi_arready
    .s_axi_rdata      (   core_ins_if.rdata     ),  // output wire [31 : 0] s_axi_rdata
    .s_axi_rresp      (   core_ins_if.rresp     ),  // output wire [1 : 0] s_axi_rresp
    .s_axi_rvalid     (   core_ins_if.rvalid    ),  // output wire s_axi_rvalid
    .s_axi_rready     (   core_ins_if.rready    ),  // input wire s_axi_rready
    .bram_rst_a       (   ins_mem_rst           ),  // output wire bram_rst_a
    .bram_clk_a       (   ins_mem_clk           ),  // output wire bram_clk_a
    .bram_en_a        (   ins_mem_en            ),  // output wire bram_en_a
    .bram_we_a        (   ins_mem_wr_en         ),  // output wire [3 : 0] bram_we_a
    .bram_addr_a      (   ins_mem_addr          ),  // output wire [13 : 0] bram_addr_a
    .bram_wrdata_a    (   ins_mem_wrdata        ),  // output wire [31 : 0] bram_wrdata_a
    .bram_rddata_a    (   ins_mem_rddata        )   // input wire [31 : 0] bram_rddata_a
);

axi_bram_ctrl_0 data_ram_ctrl_inst (
    .s_axi_aclk       (   clk     ),                // input wire s_axi_aclk
    .s_axi_aresetn    (   rst_n   ),                // input wire s_axi_aresetn
    .s_axi_awaddr     (   core_data_if.awaddr   ),  // input wire [13 : 0] s_axi_awaddr
    .s_axi_awprot     (   core_data_if.awprot   ),  // input wire [2 : 0] s_axi_awprot
    .s_axi_awvalid    (   core_data_if.awvalid  ),  // input wire s_axi_awvalid
    .s_axi_awready    (   core_data_if.awready  ),  // output wire s_axi_awready
    .s_axi_wdata      (   core_data_if.wdata    ),  // input wire [31 : 0] s_axi_wdata
    .s_axi_wstrb      (   core_data_if.wstrb    ),  // input wire [3 : 0] s_axi_wstrb
    .s_axi_wvalid     (   core_data_if.wvalid   ),  // input wire s_axi_wvalid
    .s_axi_wready     (   core_data_if.wready   ),  // output wire s_axi_wready
    .s_axi_bresp      (   core_data_if.bresp    ),  // output wire [1 : 0] s_axi_bresp
    .s_axi_bvalid     (   core_data_if.bvalid   ),  // output wire s_axi_bvalid
    .s_axi_bready     (   core_data_if.bready   ),  // input wire s_axi_bready
    .s_axi_araddr     (   core_data_if.araddr   ),  // input wire [13 : 0] s_axi_araddr
    .s_axi_arprot     (   core_data_if.arprot   ),  // input wire [2 : 0] s_axi_arprot
    .s_axi_arvalid    (   core_data_if.arvalid  ),  // input wire s_axi_arvalid
    .s_axi_arready    (   core_data_if.arready  ),  // output wire s_axi_arready
    .s_axi_rdata      (   core_data_if.rdata    ),  // output wire [31 : 0] s_axi_rdata
    .s_axi_rresp      (   core_data_if.rresp    ),  // output wire [1 : 0] s_axi_rresp
    .s_axi_rvalid     (   core_data_if.rvalid   ),  // output wire s_axi_rvalid
    .s_axi_rready     (   core_data_if.rready   ),  // input wire s_axi_rready
    .bram_rst_a       (   data_mem_rst          ),  // output wire bram_rst_a
    .bram_clk_a       (   data_mem_clk          ),  // output wire bram_clk_a
    .bram_en_a        (   data_mem_en           ),  // output wire bram_en_a
    .bram_we_a        (   data_mem_wr_en        ),  // output wire [3 : 0] bram_we_a
    .bram_addr_a      (   data_mem_addr         ),  // output wire [13 : 0] bram_addr_a
    .bram_wrdata_a    (   data_mem_wrdata       ),  // output wire [31 : 0] bram_wrdata_a
    .bram_rddata_a    (   data_mem_rddata       )   // input wire [31 : 0] bram_rddata_a
);

single_ram #(
    .DATA_WIDTH   ( DATA_WIDTH  ),
    .ADDR_WIDTH   ( $clog2(DATA_RAM_DEPTH)  )
) instruction_ram_inst (
    .clk    (   ins_mem_clk     ),
    .rst    (   ins_mem_rst     ),
    .ena    (   ins_mem_en      ),
    .wr_en  (   ins_mem_wr_en   ),
    .din    (   ins_mem_wr      ),
    .addr   (   ins_mem_addr    ),
    .dout   (   ins_mem_rd      )
);

single_ram #(
    .DATA_WIDTH   ( DATA_WIDTH  ),
    .ADDR_WIDTH   ( $clog2(DATA_RAM_DEPTH)  )
) data_ram_inst (
    .clk    (   data_mem_clk    ),
    .rst    (   data_mem_rst    ),
    .ena    (   data_mem_en     ),
    .wr_en  (   data_mem_wr_en  ),
    .din    (   data_mem_wr     ),
    .addr   (   data_mem_addr   ),
    .dout   (   data_mem_rd     )
);

endmodule
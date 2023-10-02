module dma_top  #( parameter WIDTH = 8 ) (
	input  wire                                                  clk,            
    input  wire                                               arst_n,                    
    input  wire                               [WIDTH-1:0]  ctrl_data,                           
    input  wire                               [WIDTH-1:0]  ctrl_addr,                        
    input  wire                                           ctrl_RD_en,
    input  wire                                           ctrl_WR_en, 
     
    output wire                          [WIDTH-1:0]  dma_txAdrr_out,
    output wire                          [WIDTH-1:0]  dma_rxAdrr_out,
    output wire                                             dma_busy, 
    output wire                           [WIDTH-1:0]           Rdata,
    output wire                                                 Valid,
    output wire                                              Interupt
	
);

wire                      [WIDTH-1:0]        data_len;
wire                                            start;

////////////////////////////////////////////////////////
/////////////////// dma_reg_file Instantation //////////
////////////////////////////////////////////////////////

dma_reg_file  dma_reg_file_Inst(
     .clk(clk)
    ,.arst_n(arst_n)
	,.data_len(data_len)
    ,.dma_txAdrr_out(dma_txAdrr_out)
    ,.dma_rxAdrr_out(dma_rxAdrr_out)
    ,.ctrl_addr(ctrl_addr)
    ,.ctrl_data(ctrl_data)
    ,.start(start)
    ,.ctrl_RD_en(ctrl_RD_en) 
    ,.Rdata(Rdata)
    ,.ctrl_WR_en(ctrl_WR_en)  );
	
////////////////////////////////////////////////////////
/////////////////// dma_fsm Instantation //////////
////////////////////////////////////////////////////////

dma_fsm dma_fsm_Inst (
    .clk(clk)
    ,.arst_n(arst_n)
    ,.data_len(data_len)
    ,.ctrl_WR_en(ctrl_WR_en)
	,.start(start)
    ,.ctrl_RD_en(ctrl_RD_en)
    ,.Valid(Valid)
    ,.dma_busy(dma_busy)
    ,.Interupt(Interupt));



endmodule 
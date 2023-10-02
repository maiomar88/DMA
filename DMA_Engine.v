module DMA_Engine  #( parameter WIDTH = 8 ) 
(
input  wire                                                  clk,
input  wire                                               arst_n,	
input  wire                               [WIDTH-1:0]  ctrl_data,                           
input  wire                               [WIDTH-1:0]  ctrl_addr,
input  wire                                           ctrl_RD_en, 
input  wire                                           ctrl_WR_en,                            
output wire                                             dma_busy,
output wire                            [WIDTH-1:0]         Rdata,
output wire                                                 Valid,
output wire                                              Interupt	
);
 //internal signal                     
wire                          [WIDTH-1:0]  dma_txAdrr_out;
wire                          [WIDTH-1:0]  dma_rxAdrr_out;
wire                                            mem_wr_en;                                        
wire                          [WIDTH-1:0]     rx_mem_addr; 
wire                          [WIDTH-1:0]     tx_mem_addr; 
wire                          [WIDTH-1:0]     data_tx_out; 
wire                          [WIDTH-1:0]      data_rx_in; 

////////////////////////////////////////////////////////
/////////////////// mem_bus Instantation ///////////////
////////////////////////////////////////////////////////
mem_bus mem_bus_inst(
	.clk(clk)
	,.mem_wr_en  (mem_wr_en)
	,.tx_mem_addr(dma_txAdrr_out)
	,.rx_mem_addr(dma_rxAdrr_out)
	,.data_tx_out(data_tx_out)
	,.data_rx_in (data_rx_in) );

////////////////////////////////////////////////////////
/////////////////// dma_top Instantation ///////////////
////////////////////////////////////////////////////////
dma_top dma_top_instant (
	.clk(clk)
   ,.arst_n(arst_n) 
   ,.ctrl_data(ctrl_data)
   ,.ctrl_addr(ctrl_addr)
   ,.ctrl_RD_en(ctrl_RD_en)
   ,.ctrl_WR_en(ctrl_WR_en)
   ,.dma_busy(dma_busy)
   ,.Rdata(Rdata)
   ,.Valid(Valid)
   ,.dma_txAdrr_out(dma_txAdrr_out)
   ,.dma_rxAdrr_out(dma_rxAdrr_out)
   ,.Interupt(Interupt)
   );
	                    
endmodule 

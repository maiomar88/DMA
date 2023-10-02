module mem_bus #( parameter WIDTH = 8 ) 
(   
    input  wire                                clk, 
    input  wire                          mem_wr_en,                                        
    input  wire        [WIDTH-1:0]     rx_mem_addr, 
    input  wire        [WIDTH-1:0]     tx_mem_addr, 
    input  wire        [WIDTH-1:0]     data_tx_out, 
    output wire        [WIDTH-1:0]     data_rx_in
);


////////////////////////////////////////////////////////
/////////////////// tx_mem Instantation ////////////////
////////////////////////////////////////////////////////

TX_Rom tx_mem (.tx_mem_addr(tx_mem_addr),.data_tx_out(data_tx_out));

////////////////////////////////////////////////////////
/////////////////// rx_mem Instantation ////////////////
////////////////////////////////////////////////////////
RX_Rom rx_mem (.mem_wr_en(mem_wr_en),.clk(clk),.rx_mem_addr(rx_mem_addr),.data_rx_in(data_rx_in));

endmodule 
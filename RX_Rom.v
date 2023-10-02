module RX_Rom  #( parameter WIDTH = 8 ) (

    input  wire                                  clk,
    input  wire                             mem_wr_en,
    input  wire  [WIDTH-1:0]              rx_mem_addr,  
    input  wire  [WIDTH-1:0]               data_rx_in
);

    reg [WIDTH-1:0] rx_memory [WIDTH-1:0];    // 2D Array    
//********************************memory intialization****************************//
initial begin                                          
  for (i = 0;i < WIDTH;i = i + 1) begin
    rx_memory[i] = 0;
  end
end
//**********************************sync_write************************************//
    always @(posedge clk) begin

		if (mem_wr_en)
            rx_memory[rx_mem_addr] <= data_rx_in; 
          
       end
endmodule
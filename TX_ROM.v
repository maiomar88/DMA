module TX_Rom  #( parameter WIDTH = 8  ) (

    input  wire  [WIDTH-1:0]              tx_mem_addr,  
    output reg   [WIDTH-1:0]               data_tx_out

);

integer i;
reg [WIDTH-1:0] tx_memory [WIDTH-1:0];             // 2D Array

//********************************memory intialization****************************//
initial begin                                          
  for (i = 0;i < WIDTH;i = i + 1) begin
    tx_memory[i] = i;
  end
end
//**********************************async_read************************************//
    always @(*) begin
            data_tx_out <= tx_memory[tx_mem_addr];          
       end
endmodule
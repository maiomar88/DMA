module dma_reg_file #( parameter WIDTH = 8 ) (
    input  wire                                              clk,            
    input  wire                                           arst_n,                    
    input  wire                     [WIDTH-1:0]        ctrl_data,                           
    input  wire                     [WIDTH-1:0]        ctrl_addr,
    input  wire                                       ctrl_RD_en, 
    input  wire                                       ctrl_WR_en, 

    output reg                       [WIDTH-1:0]           Rdata,      
    output wire                      [WIDTH-1:0]  dma_txAdrr_out,
    output wire                      [WIDTH-1:0]  dma_rxAdrr_out,
    output wire                      [WIDTH-1:0]        data_len,
    output wire                                            start
);

// Define registers

reg [WIDTH-1:0]          ctrl_reg;  
reg [WIDTH-1:0]      data_len_reg;  
reg [WIDTH-1:0]       tx_addr_reg;  
reg [WIDTH-1:0]       rx_addr_reg;  
reg [WIDTH-1:0]        Status_reg; 

//encoding
parameter   [2:0]            control      = 3'b000,
                         data_length      = 3'b001,
                               txAdrr     = 3'b010,
                            rxAdrr        = 3'b011,
                            status        = 3'b100;

//register updates
always @(posedge clk or posedge arst_n) begin

    if (arst_n) begin
                                  // Initialize registers on reset
        ctrl_reg     <= 8'b0;
        data_len_reg <= 8'b0;
        tx_addr_reg  <=  'b0;
        rx_addr_reg  <=  'b0;
        Status_reg   <= 8'b0;

end else if(ctrl_RD_en) begin   
   ctrl_reg[0]<=0;                                                                       
        case (ctrl_addr)
      control: Rdata<= ctrl_reg;  
  data_length: Rdata<= data_len_reg ;     
       txAdrr: Rdata<= tx_addr_reg  ;    
       rxAdrr: Rdata<= rx_addr_reg  ;       
       status: Rdata<= Status_reg   ;
    endcase
      
    end
else if (ctrl_WR_en) begin
    case (ctrl_addr)
      control: ctrl_reg     <= ctrl_data;  
  data_length: data_len_reg <= ctrl_data;     
       txAdrr: tx_addr_reg  <= ctrl_data;    
       rxAdrr: rx_addr_reg  <= ctrl_data;       
    endcase
end
     else 
        ctrl_reg[0]<=0;   
end



// Assign the output signals
assign    dma_busy       = Status_reg[0];                  // Busy signal from Status Register
assign    dma_txAdrr_out =   tx_addr_reg;
assign    dma_rxAdrr_out =   rx_addr_reg;
assign    data_len       =  data_len_reg;
assign    start          =   ctrl_reg[0];
endmodule


module dma_fsm  #( parameter WIDTH = 8 )
 
(
input  wire                                          clk,
input  wire                                       arst_n,
input  wire                                    ctrl_RD_en, 
input  wire                                    ctrl_WR_en,                            
input  wire                [WIDTH-1:0]           data_len,
input  wire                                         start,
output reg                                       dma_busy,
output reg                                          Valid,
output reg                                        Interupt
);


//  state encoding
parameter   [1:0]      IDLE      = 2'b00,
                       READ      = 2'b01,
					             WRITE     = 2'b10,
					             CHECK     = 2'b11;
					       
             

reg         [1:0]                current_state , next_state ;
reg         [WIDTH-1:0]                             count;
			
//state transiton 
always @ (posedge clk or negedge arst_n) begin
  if(!arst_n) begin
    current_state <= IDLE ;
  
 end else  begin
    current_state <= next_state ;
   end
 end
 
 

// next state logic
always @ (*)
 begin
  dma_busy = 1'b0;
  Valid    = 1'b0;
  Interupt = 1'b0;
  case(current_state)
  IDLE   : begin
            if(start)
			 next_state = CHECK ;
			else
			 next_state = IDLE ; 			
           end
  CHECK  : begin
    
  if(ctrl_RD_en) begin
            next_state = READ ;
            dma_busy   = 1'b1;
  
 end else if(ctrl_WR_en) begin
            next_state = WRITE ;
            dma_busy   = 1'b1;      
   end else 
            next_state =  IDLE ; 
            end
  READ  : begin
         if(!ctrl_RD_en && count == data_len ) begin
              next_state = CHECK;
              Valid      = 1'b1;
              Interupt   = 1'b1;
      end  else 
              next_state = READ ;      
           end

  WRITE : begin
         if(!ctrl_WR_en && count == data_len ) begin
              next_state = CHECK;
              Interupt   =1'b1;
        end
        else 
              next_state = WRITE ;      
           end

endcase

end

always @ (posedge clk or negedge arst_n) begin
  if(!arst_n)
             count  <= 0;
   else if ( (current_state == READ)|| (current_state == WRITE)) 
             count  <= count +1;
   else if (current_state == CHECK)
             count  <= 0;

   end

     endmodule
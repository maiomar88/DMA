`timescale 1ns/1ps
module DMA_Engine_tb #( parameter WIDTH = 8 )();

reg                                                 clk_tb;
reg                                                 arst_n_tb;	
reg                           [WIDTH-1:0]     ctrl_data_tb;                          
reg                           [WIDTH-1:0]     ctrl_addr_tb;
reg                                          ctrl_RD_en_tb;
reg                                          ctrl_WR_en_tb;                           
wire                                           dma_busy_tb;
wire                          [WIDTH-1:0]         Rdata_tb;
wire                                              Valid_tb;
wire                                           Interupt_tb;	


//Initial 
initial
 begin

initialize() ;                            //initialization
reset();                                 //Reset the design
data_lenth(3,1);                        //addr=1 ,lenth=3
TX_data(4,2);                          //Adrr=2 , txadrr=4
RX_data(7,3);
START(1,0);
READ_txadrr(2);

repeat(100)@(negedge clk_tb) $stop ;

end

////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////

task initialize ;
 begin

  clk_tb        = 1'b0 ; 
  ctrl_RD_en_tb = 1'b0 ; 
  ctrl_WR_en_tb = 1'b0 ;

 end
endtask

///////////////////////// RESET /////////////////////////

task reset ;
 begin
   arst_n_tb = 1'b1  ;             // rst is deactivated
  repeat(5)@(negedge clk_tb);
   arst_n_tb = 1'b0  ;            // rst is activated
 
 end
endtask

/////////////////////////data_lenth /////////////////////////
task data_lenth ; 
input [WIDTH-1:0] data_lenth_n;
input [WIDTH-1:0] Addr_1;

 begin
 
ctrl_data_tb   = data_lenth_n;
 ctrl_addr_tb  = Addr_1;
 ctrl_WR_en_tb =   1'b1;
  repeat(1)@(negedge clk_tb);
 ctrl_WR_en_tb =   1'b0;
 end
endtask

/////////////////////////TX_data /////////////////////////
task TX_data ; 
input [WIDTH-1:0] TX_data;
input [WIDTH-1:0] Addr_2;

 begin
 
ctrl_data_tb   = TX_data;
ctrl_addr_tb   = Addr_2;
 ctrl_WR_en_tb =   1'b1;
  repeat(1)@(negedge clk_tb);
 ctrl_WR_en_tb =   1'b0;
 end
endtask

/////////////////////////RX_data /////////////////////////
task RX_data ; 
input [WIDTH-1:0] RX_data;
input [WIDTH-1:0] Addr_3;

 begin
 
ctrl_data_tb   = RX_data;
ctrl_addr_tb   = Addr_3;
 ctrl_WR_en_tb =   1'b1;
  repeat(1)@(negedge clk_tb);
 ctrl_WR_en_tb =   1'b0;
 end
endtask

/////////////////////////Start/////////////////////////
task START; 
input [WIDTH-1:0] STARTone;
input [WIDTH-1:0] Addr_0;

 begin
 
ctrl_data_tb   = STARTone;
ctrl_addr_tb   = Addr_0;
 ctrl_WR_en_tb =   1'b1;
  repeat(1)@(negedge clk_tb);
 ctrl_WR_en_tb =   1'b0;
 end
endtask

/////////////////////////READ/////////////////////////
task READ_txadrr; 

input [WIDTH-1:0] Addr_2;

 begin
 
ctrl_addr_tb   = Addr_2;
 ctrl_RD_en_tb =   1'b1;
  repeat(5)@(negedge clk_tb);
 ctrl_RD_en_tb =   1'b0;
 end
endtask


////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////

always #5 clk_tb = ~clk_tb ;

////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////
DMA_Engine DUT (
.clk(clk_tb),
.arst_n(arst_n_tb),    
.ctrl_data(ctrl_data_tb),                           
.ctrl_addr(ctrl_addr_tb),
.ctrl_RD_en(ctrl_RD_en_tb),
.ctrl_WR_en(ctrl_WR_en_tb),                        
.dma_busy(dma_busy_tb),
.Rdata(Rdata_tb),
.Valid(Valid_tb),
.Interupt(Interupt_tb)  );

endmodule 
// ------------------------------------------//
// Register File for SPU-Lite Processor
// ------------------------------------------//
// Authors:
// NAME:  Atif Iqbal                           
// NETID: aahangar                             
// SBUID: 111416569                            
//
// NAME: Karthik Raj
// NETID: karamachandr 
// SBUID: 111675685
// ------------------------------------------//

import defines_pkg::*;

module spu_tb();

   logic clk;
   logic rst;

   initial clk=0;
   always #5 clk = ~clk;

   spu_top u_spu_top (
       .clk(clk),
       .rst(rst)
   );
   
   initial begin
     
     // reset
     @(posedge clk); rst = 1; 
     @(posedge clk); rst = 0; 

     repeat(1000) @(posedge clk);

     //TODO: Don't need this..remove this
     $finish;
   end

endmodule

`timescale 1ns/1ps

module clock_divider
#(
   parameter N=300_000
 )
 (
  input      clk,
  input      rst_l,
  output reg div_clk
  );
   
   integer   clk_count;
   initial begin
      clk_count = 0;
      div_clk   = 0;
   end
   
   always @(posedge clk, negedge rst_l) begin
      // RESET BEHAVIOR:
      if (!rst_l) begin
         clk_count <= 0;
         div_clk   <= 0;
      end
      // NORMAL BEHAVIOR:
      // Pulse div_clk every N clock cycles.
      else begin
         if (clk_count == N) begin
            clk_count <= 0;
            div_clk   <= 1;
         end 
         else begin
            clk_count <= clk_count + 1;
            div_clk   <= 0;
         end 
      end 
   end // always @ (posedge clk, negedge rst_l)
   
endmodule // clock_divider
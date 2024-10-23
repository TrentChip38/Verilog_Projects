`timescale 1ns/1ps

module keypad
  #(
     parameter N=300_000
   )
   (
     input             clk,
     input             rst_l,
     input      [3:0]  row,
     output     [3:0]  col,
     output reg [15:0] keys
   );

   wire          scan;
   reg   [1:0]   state;

   initial begin
      state = 0;
      keys  = 0;
   end

   clock_divider clkdiv(.clk(clk),.rst_l(rst_l),.div_clk(scan));

    assign col[0] = (state == 0) ? 0 : 1'bz;
    assign col[1] = (state == 1) ? 0 : 1'bz;
    assign col[2] = (state == 2) ? 0 : 1'bz;
    assign col[3] = (state == 3) ? 0 : 1'bz;

   always @(posedge clk, negedge rst_l) begin
      if (!rst_l) begin         
         state <= 0;
         keys  <= 0;
      end
      else if (scan) begin
         case (state)
           0:
             begin
                // Set the key values for this column:
                keys[4'h1] <= ~row[0];
                keys[4'h4] <= ~row[1];
                keys[4'h7] <= ~row[2];
                keys[4'h0] <= ~row[3];
                // Proceed to the next state:
                state    <= 1;                
             end
           1:
             begin
               // Set the key values for this column:
                keys[4'h2] <= ~row[0];
                keys[4'h5] <= ~row[1];
                keys[4'h8] <= ~row[2];
                keys[4'hF] <= ~row[3];
                // Proceed to the next state:
                state    <= 2;   
             end
           2: 
             begin
               // Set the key values for this column:
                keys[4'h3] <= ~row[0];
                keys[4'h6] <= ~row[1];
                keys[4'h9] <= ~row[2];
                keys[4'hE] <= ~row[3];
                // Proceed to the next state:
                state    <= 3;
              end
           3:
             begin
               // Set the key values for this column:
                keys[4'hA] <= ~row[0];
                keys[4'hB] <= ~row[1];
                keys[4'hC] <= ~row[2];
                keys[4'hD] <= ~row[3];
                // Proceed to the next state:
                state    <= 0;
             end
         endcase
      end
   end

endmodule
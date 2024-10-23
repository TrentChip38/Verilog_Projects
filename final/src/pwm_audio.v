`timescale 1ns/1ps

module pwm_audio(
   input       clk,
   input       rst_n,
   input [7:0] volume,
   input [9:0] N,
   output reg  sout
   );
   
   

   reg [9:0] f_count;  // counter for frequency synthesis
   reg       f_clk;    // divided clock
   reg [7:0] dc_count; // counter for duty cycle
   
   initial begin
      f_count  = 0;
      sout     = 0;
      f_clk    = 0;
      dc_count = 0;
   end
   
   // First clock divider sets the tone frequency:
   always @(posedge clk, negedge rst_n) begin
      if (!rst_n) begin
         f_count = 0;
	 f_clk   = 0;
      end
      else begin
         if (f_count >= N) begin
	    f_count <= 0;
	    f_clk   <= ~f_clk;
	 end
	 else
	    f_count <= f_count + 1;
      end // else: !if(!rst_n)
   end

  //  Second clock divider sets the duty cycle:
   always @(posedge f_clk, negedge rst_n) begin
      if (!rst_n) begin
         dc_count <= 0;
	 sout  <= 0;
      end
      else begin
         dc_count <= dc_count + 1;
         if (dc_count < volume)
	    sout <= 1;
	 else
	    sout <= 0;
      end
   end
endmodule


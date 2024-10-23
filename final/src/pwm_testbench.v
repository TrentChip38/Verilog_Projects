`timescale 1ns/1ps

module pwm_testbench ();
   
   // DECLARE SIGNALS
   reg  clk;
   reg 	rst;
   reg [7:0] volume = 245;
   wire sout;

   integer     clk_count     = 0;   
   integer     div_count     = 0;   
   reg   [9:0]  N = 747;

   // KEYPAD MODULE
   pwm_audio pulse
     (
      clk,
      rst,
      volume,
      N,
      sout
      );

   // Timing to change key value every
   // refresh interval
   clock_divider #(.N(1_200_000)) clkdiv
   (.clk(clk),.rst_l(rst_l),.div_clk(refresh));
   
   
   // INITIAL SIGNAL CONFIGURATION:
   initial begin
      clk   = 0;
      rst = 1;  // start up in reset condition
      clk_count     = 0;
   end

   // GENERATE CLOCK:
   initial forever #10 clk = ~clk;
   
   // WRITE OUTPUT TO CONSOLE:
   integer fid;
   initial fid = $fopen("pwm_test_result.txt", "w");
   
   always @(posedge clk) begin
    if(div_count == 3000) begin
	 $write("clk: %d", clk_count);
	 $write("N: %d", N);
	 $write("\tsout: %d", sout);
	 $write("\n");
	 
	 $fwrite(fid,"clk:  %d", clk_count);
	 $fwrite(fid,"N: %d", N);
     $fwrite(fid,"\tsout: %d", sout);
	 $fwrite(fid,"\n");
     div_count = 0;
    end
    else
        div_count = div_count + 1;
   end

   always @(posedge clk) begin
      clk_count <= clk_count + 1;
      if (clk_count == 2000000) begin
	 $fclose(fid);
	 $finish;
      end
   end
   
endmodule // testbench

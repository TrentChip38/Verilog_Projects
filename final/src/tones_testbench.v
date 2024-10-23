`timescale 1ns/1ps

module tones_testbench ();
   
   // DECLARE SIGNALS
   reg  clk;
   reg 	rst;
   reg [7:0] volume = 245;
   reg [15:0] keys = 0;
   wire sout;

   integer     clk_count     = 0;   
   integer     div_count     = 0;   

   wire AIN;
   wire GAIN;
   wire SHUTDOWN_L;
   wire   [9:0]  N;

   // KEYPAD MODULE
   tones DUT
     (
      clk,
      rst,
      volume,
      keys,
      AIN,
      GAIN,
      SHUTDOWN_L,
      N
      );
   
   // INITIAL SIGNAL CONFIGURATION:
   initial begin
      clk   = 0;
      rst = 1;  // start up in reset condition
   end

   // GENERATE CLOCK:
   initial forever #10 clk = ~clk;
   
   // WRITE OUTPUT TO CONSOLE:
   integer fid;
   initial fid = $fopen("piano_test_result.txt", "w");
   
   always @(N)begin
       $write("clk:%d", clk_count);
	    $write("  keys: %b", keys);
	    $write("\tTone: %d", N);
       if (GAIN && SHUTDOWN_L)
          $write(" ON ");
	    $write("\n");
	 
	    $fwrite(fid,"clk: %d", clk_count);
	    $fwrite(fid,"  keys: %b", keys);
       $fwrite(fid,"\tTone: %d", N);
       if (GAIN && SHUTDOWN_L)
          $fwrite(fid, " ON ");
	    $fwrite(fid,"\n");
   end
   always @(posedge clk) begin
   if(clk_count == 2000)
      keys = 1;
    if(div_count == 3000) begin
     div_count = 0;
     keys <= keys*2;
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

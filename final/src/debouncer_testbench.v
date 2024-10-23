`timescale 1ns/1ps

module debouncer_testbench ();
   
   // DECLARE SIGNALS
   reg clk;     
   reg rst;
   reg btn;

   reg btn_d;   // delayed button (to detect changes)
   reg led_d;   // delayed led
   reg state_d; // delayed debouncer state
   reg clear_d; // delayed clear signal
   reg t_d;     // delayed timer alarm
   
   reg value_change;
   
   wire led;
   
   integer clk_count   = 0;   
   integer clk_count_d = 0; // delayed clock count   

   // DEVICE UNDER TEST
   debouncer DUT
  (
   .clk(clk),
   .b(btn),
   //.rst(rst),     
   .d(led)
   );
   
   always @(*) begin
      value_change = btn ^ btn_d;
      value_change = value_change | (led ^ led_d);
      value_change = value_change | (DUT.state ^ state_d);
      value_change = value_change | (DUT.d ^ led);
   end
   
   // INITIAL SIGNAL CONFIGURATION:
   initial begin
      clk = 0;      
      rst = 1;
      btn = 0;

      $dumpfile("debounce.vcd");
      $dumpvars(1,DUT.d);
      
   end

   // GENERATE CLOCK:
   initial forever #10 clk = ~clk;
   
   // CREATE STIMULI:
   always @(posedge clk) begin
      btn_d   <= btn;
      led_d   <= led;
      state_d <= DUT.state;
      t_d     <= DUT.d;
      
      if (rst) begin
	 rst <= 0;
      end
      else begin
	 case (clk_count)
	   10: // start button press
	     btn <= 1;
	   20: // bounce
	     btn <= 0;
	   24: //bounce
	     btn <= 1;
	   30: //bounce
	     btn <= 0;
	   31: // now sustain
	     btn <= 1;
	   200: // release
	     btn <= 0;
	   210: // bounce
	     btn <= 1;
	   215: // bounce
	     btn <= 0;
	   230: //bounce
	     btn <= 1;
	   235: //sustain
	     btn <= 0;
     450: // bounce
        btn <= 1;
     455: // bounce
        btn <= 0;
     460: // bounce
        btn <= 1;
     465: // bounce
        btn <= 0;
	   	   
	 endcase // case (clk_count)
	 
      end
   end

   

   // WRITE OUTPUT TO CONSOLE:
   integer fid;
   initial fid = $fopen("debouncer_test_result.txt", "w");
   
   always @(posedge clk) begin
      // write data if there is a change:
      if (value_change) begin
	 clk_count_d <= clk_count;
	 
	 $write("clk:  %4d", clk_count);      
	 $write(" clk diff:  %4d", clk_count-clk_count_d);
	 $write(" state: %1d", DUT.state);
	 //$write(" clear: %b", DUT.db1.clear);
	 $write(" t: %b", DUT.d);
	 $write(" btn: %b", btn);
	 $write(" led:  %d", led);
	 $write("\n");
	 
	 $fwrite(fid,"%4d", clk_count);      
	 $fwrite(fid,"\t%4d", clk_count-clk_count_d);
	 $fwrite(fid,"\t%1d", DUT.state);
	 //$fwrite(fid,"\t%b", DUT.db1.clear);
	 $fwrite(fid,"\t%b", DUT.d);
	 $fwrite(fid,"\t%b", btn);
	 $fwrite(fid,"\t%d", led);
	 $fwrite(fid,"\n");
      end
   end

   // DEFINE WHEN TO TERMINATE SIMULATION:
   always @(posedge clk) begin
      clk_count <= clk_count + 1;
      if (clk_count == 500) begin
	 $fclose(fid);
	 $finish;
      end
   end

   
endmodule // testbench
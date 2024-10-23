`timescale 1ns/1ps

module keypad_testbench ();
   
   // DECLARE SIGNALS
   reg  clk;
   reg 	rst_l;

   // Simulated row/col for keypress position:
   reg [3:0]  row_pressed;
   reg [3:0]  col_pressed;
   
   // Interface wires:
   wire [3:0]  row_wire;
   wire [3:0]  col_wire;
   wire [15:0] keys;
   wire        refresh;
   
   integer     clk_count     = 0;   
   integer     refresh_count = 0;

   // The row wire can be pulled down only if the column wire matches
   // the column where the button is pressed:
   assign row_wire[0] = &(col_wire===col_pressed) ? row_pressed[0] : 1 ;
   assign row_wire[1] = &(col_wire===col_pressed) ? row_pressed[1] : 1 ;
   assign row_wire[2] = &(col_wire===col_pressed) ? row_pressed[2] : 1 ;
   assign row_wire[3] = &(col_wire===col_pressed) ? row_pressed[3] : 1 ;
   
   
   // KEYPAD MODULE
   keypad #(.N(300_000)) kypd
     (
      .clk(clk),
      .rst_l(rst_l),
      .col(col_wire),
      .row(row_wire),
      .keys(keys)
      );

   // Timing to change key value every
   // refresh interval
   clock_divider #(.N(1_200_000)) clkdiv
   (.clk(clk),.rst_l(rst_l),.div_clk(refresh));
   
   
   // INITIAL SIGNAL CONFIGURATION:
   initial begin
      clk   = 0;
      rst_l = 0;  // start up in reset condition

      // Initially no button is pressed, we will start
      // pressing buttons in column zero:
      row_pressed   = 4'b1111;   
      col_pressed   = 4'bZZZ0;
      
      clk_count     = 0;
      refresh_count = 0;
   end

   // GENERATE CLOCK:
   initial forever #10 clk = ~clk;
   

   // CREATE STIMULI:
   always @(posedge clk) begin
      // Control the reset behavior:
      if (!rst_l) begin
	 rst_l <= 1;
	 row_pressed   <= 4'b1111; // No key pressed, all rows HIGH	 
      end
      else begin
	 if (refresh) begin
	    case (row_pressed)
	      4'b1111: row_pressed <= 4'b1110; // first row_pressed
	      4'b1110: row_pressed <= 4'b1101; // second row_pressed
	      4'b1101: row_pressed <= 4'b1011; // third row_pressed
	      4'b1011: row_pressed <= 4'b0111; // fourth row_pressed
	      4'b0111: // After the last row, we change column and 
		begin  // start going through the rows again:
		   row_pressed <= 4'b1111; 
		   
		   case (col_pressed)
		     4'bZZZ0 : col_pressed <= 4'bZZ0Z;
		     4'bZZ0Z : col_pressed <= 4'bZ0ZZ;
		     4'bZ0ZZ : col_pressed <= 4'b0ZZZ;
		     4'b0ZZZ : col_pressed <= 4'bZZZ0;
		   endcase // case (col_pressed)
		end
	    endcase
	 end
      end
   end

   // WRITE OUTPUT TO CONSOLE:
   integer fid;
   initial fid = $fopen("keypad_test_result.txt", "w");
   
   always @(posedge clk) begin
      if (kypd.scan) begin
	 $write("clk: %d", clk_count);      
	 $write("\tpressed(col: %b", col_pressed);
	 $write(", row: %b)", row_pressed);
	 $write("\twire(col: %b", col_wire);
	 $write(", row: %b)", row_wire);
	 $write("\tkeys: %b", keys);
	 $write("\n");
	 
	 $fwrite(fid,"clk:  %d", clk_count);
	 $fwrite(fid,"\tcol: %b", col_wire);
	 $fwrite(fid,"\trow: %b", row_wire);
	 $fwrite(fid,"\tkeys: %b", keys);
	 $fwrite(fid,"\n");
      end
   end

   // DEFINE WHEN TO TERMINATE SIMULATION:
   // we want to test all button positions, but it
   // takes a full refresh cycle for each button,
   // so we want to terminate after at least 20
   // refresh events:
   always @(posedge clk) begin
      clk_count <= clk_count + 1;
      if (refresh)
	refresh_count <= refresh_count + 1;
      
      if (refresh_count == 21) begin
	 $fclose(fid);
	 $finish;
      end
   end

   
endmodule // testbench

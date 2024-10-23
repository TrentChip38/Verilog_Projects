`timescale 1ns/1ps

module oled_demo 
  (
   
   input 	clk,
   input 	rst,

   input 	showchar,
   input 	showbmp,
   input 	clear,
   
   input [15:0] sw,

		   
   output 	ready,
		   
		   // OLED header signals:
   output 	cs_n,
   output 	sdo,
   output 	sclk,
   output 	dc,
   output 	vbat,
   output 	vdd,
   output 	res
   );

   reg [7:0]   charval;
   reg [1:0]   char_row;
   reg [3:0]   char_col;
   reg [1:0]   bmp;

   reg 	       rst_n;
   
   always @(*) begin
      charval  = sw[7:0];
      char_row = sw[9:8];
      char_col = sw[13:10];
      bmp      = sw[15:14];
      rst_n    = ~rst;
      
   end

   
   oledDriver oled 
     (
      .clk(clk),
      .rst_n(rst_n),
      .showchar(showchar),
      .showbmp(showbmp),
      .clear(clear),
      .charval(charval),
      .char_row(char_row),
      .char_col(char_col),      
      .bmp(bmp),
      .ready(ready),		   
      // OLED header signals:
      .cs_n(cs_n),
      .sdo(sdo),
      .sclk(sclk),
      .dc(dc),
      .vbat(vbat),
      .vdd(vdd),
      .res(res)
      );

endmodule

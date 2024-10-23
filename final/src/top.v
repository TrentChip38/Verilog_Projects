`timescale 1ns/1ps

module top 
  (
   input 	clk,
   input [15:0] sw,
   input         btnU,
   input  [3:0]  row,
   output [3:0]  col,
   output [15:0] led,
	 output AIN,
	 output GAIN,
   output SHUTDOWN_L,
   //output 	ready,
	// OLED header signals:
   output 	cs_n,
   output 	sdo,
   output 	sclk,
   output 	dc,
   output 	vbat,
   output 	vdd,
   output 	res
   );
   
   wire showchar;
   wire showbmp;
   wire 	clear;
   wire [7:0]   charval;
   wire [1:0]   char_row;
   wire [3:0]   char_col;
   wire [1:0]   bmp;
   wire [15:0] keys;
   reg 	       rst_n;

   debouncer toggle(btnU, clk, rst);
   game maingame(clk,
   //input [15:0] sw, 
   rst, keys, led,
   showchar, showbmp, clear,
   charval, char_row, char_col, bmp,
   AIN, GAIN, SHUTDOWN_L
   );
   keypad #(.N(300_000)) kypd
    (
      .clk(clk),
      .rst_l(1),//~rst
      .row(row),
      .col(col),
      .keys(keys[15:0])
      );
   
   
   oledDriver oled 
     (
      .clk(clk),
      .rst_n(1),//~rst
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


/*
module top
  (
     input         clk,
     input         btnU,
     input  [3:0]  row,
     input  [15:0]  sw,
     output [3:0]  col,
     //output [15:0] keys,
	   output AIN,
	   output GAIN,
     output SHUTDOWN_L,
     output cs_n,
     output sdo,
     output sclk,
     output dc,
     output vbat,
     output vdd,
     output res,
     output ready
   );
reg showchar = 0;
reg showbmp = 1;
reg clear = 0;
reg char_col = 1;
reg char_row = 1;
reg charval = 65;
reg bmp = 1;

 debouncer toggle(btnU, clk, rst);
  keypad #(.N(300_000)) kypd
    (
      .clk(clk),
      .rst_l(~rst),
      .row(row),
      .col(col),
      .keys(keys[15:0])
      );

  oledDriver oled 
     (
      .clk(clk),
      .rst_n(~rst),
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

endmodule*/
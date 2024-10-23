`timescale 1ns/1ps

module game 
  (
   input 	clk,
   //input [15:0] sw,
   input         rst,
   input [15:0]  keys,
   output [15:0] led,
   //output 	ready,
	// OLED header signals:
   output showchar,
   output showbmp,
   output clear,
   output charval,
   output char_row,
   output char_col,      
   output bmp,
   output AIN,
   output GAIN,
   output SHUTDOWN_L
   );
   reg  [7:0] vari1;
   reg  [7:0] vari2;
   reg  [7:0] ans;
   reg  [7:0] ans1;
   reg  [7:0] ans2;
   reg  [7:0] uans1;
   reg  [7:0] uans2;
   reg showchar = 0;
   reg showbmp = 1;
   reg 	clear = 0;
   reg [7:0]   charin = 90;
   reg [7:0]   charval = 90;
   reg [1:0]   char_row = 1;
   reg [3:0]   char_col = 2;
   reg [1:0]   bmp = 0;
   wire [15:0] keys;
   reg 	       rst_n;
   reg [6:0] state = 0;
   reg [6:0] que = 0;
   reg [7:0] score = 0;
   integer count = 0;
   integer win_score = 10;
   wire div_clk;
   assign led [9:0] = score[7:0];//keys[9:0];
   assign led [15:10] = state;
   reg [15:0] tone = 0;

tones sound(clk, 1, 10, tone, AIN, GAIN, SHUTDOWN_L);


   clock_divider #(30000000) div(clk, 1, div_clk);
   always @(posedge div_clk)begin//posedge 
      if (rst)
         state <= 0;
      else if(score == win_score)begin
            state <= 39;
            score <= 0;
      end else begin
      //if enter pressed
      case (state)
      0:begin
         //show start image and initialize
         score <= 0;
         que <= 0;
         tone <= 0;
         clear <= 0;
         bmp <= 0;
         showbmp <= 1;
         charval <= 90;
         showchar <= 0;
         if(count < 2)begin
            count <= count + 1;
         end
         else begin
            state <= 1;
            count <= 0;
            showbmp <= 0;
            
         end
      end
      1:begin
         //waiting for any press to start if first question
         if (charin != 97)begin
            state <= 2;
            vari1 <= 57;
            vari2 <= 49;
            ans1 <= 57;
            ans2 <= 0;
            clear <= 1;
         end
      end
      2:begin//type space
         
         clear <= 0;
         charval <= vari1;
         if(score == win_score)
            state <= 39;
         else
            state <= 3;
         //set answers to be the multiplication of variables
         //ans <= ((vari1 - 48)*(vari2 - 48))
         //ans1 <= 42;
         //ans2 <= 0;
      end
      3:begin//type first variable
         showchar <= 1;
         char_col <= 3;//char_col + 2;
         state <= 4;
         //set answers to be the multiplication of variables
         /*if(ans < 10)begin//one digit answer
            ans1 <= ans + 48;
            ans2 <= 0;
         end
         else begin//two digit answer
            ans1 <= ans + 48 - 9;
            ans2 <= 9 - ans + 48;
         end*/
      end
      4:begin
         state <= 5;
         showchar <= 0;
         charval <= 42;
      end
      5:begin//type multiply
         showchar <= 1;
         char_col <= 5;//char_col + 2;
         state <= 6;
      end
      6:begin
         state <= 7;
         showchar <= 0;
         charval <= vari2;
      end
      7:begin//type second variable
         showchar <= 1;
         char_col <= 7;//char_col + 2;
         state <= 8;
      end
      8:begin
         state <= 9;
         showchar <= 0;
         charval <= 61;
      end
      9:begin//type equals
         showchar <= 1;
         char_col <= 9;//char_col + 2;
         state <= 10;
      end
      10:begin
         state <= 11;
         showchar <= 0;
         char_col <= 11;
      end
      11:begin//type users input and store to check
         if(charin < 60)begin
         showchar <= 1;
         charval <= charin;
         uans1 <= charin;
         state <= 12;
         end
         else begin
            showchar <= 0;
            state <= 11;
         end//char_col <= 2;
      end
      12:begin
         showchar <= 0;//added this
         state <= 13;
      end
      13:begin
         showchar <= 0;
         char_col <= 12;
         if(ans2 == 0)begin//if answer is single digit
            if(uans1 == ans1)begin
               state <= 20;
            end
            else begin
               state <= 30;
            end
         end
         else 
            state <= 14;
      end
      14:begin//type users input and store to check
         if(charin < 60)begin
         showchar <= 1;
         charval <= charin;
         uans2 <= charin;
         state <= 15;
         //char_col <= 13;
         end
         else begin
            showchar <= 0;
            state <= 14;
         end//char_col <= 2;
      end
      15:begin
         showchar <= 0;
         state <= 16;
      end
      16:begin
         if((ans1 == uans1) && (ans2 == uans2))//double digit answer
               state <= 20;
            else
               state <= 30;
      end
      20:begin//correct
         //if(count < 2)begin//wait a sec
            //count <= count + 1;
         if (count == 0)begin
            count <= count + 1;
            tone <= 16'b0000000000001000;//f#
         end else if (count == 1)begin
            count <= count + 1;
            tone <= 16'b0000000000000100;//e
         end else begin
            count <= 0;
            clear <= 1;
            score <= score + 1;
            tone <= 16'b0000000000010000;
            state <= 25;
         end
      end
      30:begin//incorrect
         if(count == 0)begin//wait a sec
            count <= count + 1;
            tone <= 16'b0000000000000100;//f#
         end else if(count == 1)begin//wait a sec
            count <= count + 1;
            tone <= 0;
         end
         else begin
            count <= 0;
            clear <= 1;
            state <= 25;
         end
      end
      25:begin
         //change variables for next question
            /*if (vari1 == 57 && vari2 == 57)
               state <= 40;
            else if (vari1 == 57)begin
               vari1 <= 49;
               vari2 <= vari2 + 1;
            end
            else
               vari1 <= vari1 + 1;*/
         //used python to generate case statement
         //with as many questions as desired
         //numbers to be hard coded in for each
         tone <= 0;
         case (que)
         0:begin
            //num1:1 num2:2 ans:2 a1:2 a2:-48
            vari1 <= 49;
            vari2 <= 50;
            ans1 <= 50;
            ans2 <= 0;
            state <= 2;
         end
         1:begin
            //num1:2 num2:2 ans:4 a1:4 a2:-48
            vari1 <= 50;
            vari2 <= 50;
            ans1 <= 52;
            ans2 <= 0;
            state <= 2;
         end
         2:begin
            //num1:3 num2:2 ans:6 a1:6 a2:-48
            vari1 <= 51;
            vari2 <= 50;
            ans1 <= 54;
            ans2 <= 0;
            state <= 2;
         end
         3:begin
            //num1:4 num2:2 ans:8 a1:8 a2:-48
            vari1 <= 52;
            vari2 <= 50;
            ans1 <= 56;
            ans2 <= 0;
            state <= 2;
         end
         4:begin
            //num1:5 num2:2 ans:10 a1:1 a2:0
            vari1 <= 53;
            vari2 <= 50;
            ans1 <= 49;
            ans2 <= 48;
            state <= 2;
         end
         5:begin
            //num1:6 num2:2 ans:12 a1:1 a2:2
            vari1 <= 54;
            vari2 <= 50;
            ans1 <= 49;
            ans2 <= 50;
            state <= 2;
         end
         6:begin
            //num1:7 num2:2 ans:14 a1:1 a2:4
            vari1 <= 55;
            vari2 <= 50;
            ans1 <= 49;
            ans2 <= 52;
            state <= 2;
         end
         7:begin
            //num1:8 num2:2 ans:16 a1:1 a2:6
            vari1 <= 56;
            vari2 <= 50;
            ans1 <= 49;
            ans2 <= 54;
            state <= 2;
         end
         8:begin
            //num1:9 num2:2 ans:18 a1:1 a2:8
            vari1 <= 57;
            vari2 <= 50;
            ans1 <= 49;
            ans2 <= 56;
            state <= 2;
         end
         9:begin
            //num1:1 num2:3 ans:3 a1:3 a2:-48
            vari1 <= 49;
            vari2 <= 51;
            ans1 <= 51;
            ans2 <= 0;
            state <= 2;
         end
         10:begin
            //num1:2 num2:3 ans:6 a1:6 a2:-48
            vari1 <= 50;
            vari2 <= 51;
            ans1 <= 54;
            ans2 <= 0;
            state <= 2;
         end
         11:begin
            //num1:3 num2:3 ans:9 a1:9 a2:-48
            vari1 <= 51;
            vari2 <= 51;
            ans1 <= 57;
            ans2 <= 0;
            state <= 2;
         end
         12:begin
            //num1:4 num2:3 ans:12 a1:1 a2:2
            vari1 <= 52;
            vari2 <= 51;
            ans1 <= 49;
            ans2 <= 50;
            state <= 2;
         end
         13:begin
            //num1:5 num2:3 ans:15 a1:1 a2:5
            vari1 <= 53;
            vari2 <= 51;
            ans1 <= 49;
            ans2 <= 53;
            state <= 2;
         end
         14:begin
            //num1:6 num2:3 ans:18 a1:1 a2:8
            vari1 <= 54;
            vari2 <= 51;
            ans1 <= 49;
            ans2 <= 56;
            state <= 2;
         end
         15:begin
            //num1:7 num2:3 ans:21 a1:2 a2:1
            vari1 <= 55;
            vari2 <= 51;
            ans1 <= 50;
            ans2 <= 49;
            state <= 2;
         end
         16:begin
            //num1:8 num2:3 ans:24 a1:2 a2:4
            vari1 <= 56;
            vari2 <= 51;
            ans1 <= 50;
            ans2 <= 52;
            state <= 2;
         end
         17:begin
            //num1:9 num2:3 ans:27 a1:2 a2:7
            vari1 <= 57;
            vari2 <= 51;
            ans1 <= 50;
            ans2 <= 55;
            state <= 2;
         end
         18:begin
            //num1:1 num2:4 ans:4 a1:4 a2:-48
            vari1 <= 49;
            vari2 <= 52;
            ans1 <= 52;
            ans2 <= 0;
            state <= 2;
         end
         19:begin
            //num1:2 num2:4 ans:8 a1:8 a2:-48
            vari1 <= 50;
            vari2 <= 52;
            ans1 <= 56;
            ans2 <= 0;
            state <= 2;
         end
         20:begin
            //num1:3 num2:4 ans:12 a1:1 a2:2
            vari1 <= 51;
            vari2 <= 52;
            ans1 <= 49;
            ans2 <= 50;
            state <= 2;
         end
         21:begin
            //num1:4 num2:4 ans:16 a1:1 a2:6
            vari1 <= 52;
            vari2 <= 52;
            ans1 <= 49;
            ans2 <= 54;
            state <= 2;
         end
         22:begin
            //num1:5 num2:4 ans:20 a1:2 a2:0
            vari1 <= 53;
            vari2 <= 52;
            ans1 <= 50;
            ans2 <= 48;
            state <= 2;
         end
         23:begin
            //num1:6 num2:4 ans:24 a1:2 a2:4
            vari1 <= 54;
            vari2 <= 52;
            ans1 <= 50;
            ans2 <= 52;
            state <= 2;
         end
         24:begin
            //num1:7 num2:4 ans:28 a1:2 a2:8
            vari1 <= 55;
            vari2 <= 52;
            ans1 <= 50;
            ans2 <= 56;
            state <= 2;
         end
         25:begin
            //num1:8 num2:4 ans:32 a1:3 a2:2
            vari1 <= 56;
            vari2 <= 52;
            ans1 <= 51;
            ans2 <= 50;
            state <= 2;
         end
         26:begin
            //num1:9 num2:4 ans:36 a1:3 a2:6
            vari1 <= 57;
            vari2 <= 52;
            ans1 <= 51;
            ans2 <= 54;
            state <= 2;
         end
         27:begin
            //num1:1 num2:5 ans:5 a1:5 a2:-48
            vari1 <= 49;
            vari2 <= 53;
            ans1 <= 53;
            ans2 <= 0;
            state <= 2;
         end
         28:begin
            //num1:2 num2:5 ans:10 a1:1 a2:0
            vari1 <= 50;
            vari2 <= 53;
            ans1 <= 49;
            ans2 <= 48;
            state <= 2;
         end
         29:begin
            //num1:3 num2:5 ans:15 a1:1 a2:5
            vari1 <= 51;
            vari2 <= 53;
            ans1 <= 49;
            ans2 <= 53;
            state <= 2;
         end
         30:begin
            //num1:4 num2:5 ans:20 a1:2 a2:0
            vari1 <= 52;
            vari2 <= 53;
            ans1 <= 50;
            ans2 <= 48;
            state <= 2;
         end
         31:begin
            //num1:5 num2:5 ans:25 a1:2 a2:5
            vari1 <= 53;
            vari2 <= 53;
            ans1 <= 50;
            ans2 <= 53;
            state <= 2;
         end
         32:begin
            //num1:6 num2:5 ans:30 a1:3 a2:0
            vari1 <= 54;
            vari2 <= 53;
            ans1 <= 51;
            ans2 <= 48;
            state <= 2;
         end
         33:begin
            //num1:7 num2:5 ans:35 a1:3 a2:5
            vari1 <= 55;
            vari2 <= 53;
            ans1 <= 51;
            ans2 <= 53;
            state <= 2;
         end
         34:begin
            //num1:8 num2:5 ans:40 a1:4 a2:0
            vari1 <= 56;
            vari2 <= 53;
            ans1 <= 52;
            ans2 <= 48;
            state <= 2;
         end
         35:begin
            //num1:9 num2:5 ans:45 a1:4 a2:5
            vari1 <= 57;
            vari2 <= 53;
            ans1 <= 52;
            ans2 <= 53;
            state <= 2;
         end
         36:begin
            //num1:1 num2:6 ans:6 a1:6 a2:-48
            vari1 <= 49;
            vari2 <= 54;
            ans1 <= 54;
            ans2 <= 0;
            state <= 2;
         end
         37:begin
            //num1:2 num2:6 ans:12 a1:1 a2:2
            vari1 <= 50;
            vari2 <= 54;
            ans1 <= 49;
            ans2 <= 50;
            state <= 2;
         end
         38:begin
            //num1:3 num2:6 ans:18 a1:1 a2:8
            vari1 <= 51;
            vari2 <= 54;
            ans1 <= 49;
            ans2 <= 56;
            state <= 2;
         end
         39:begin
            //num1:4 num2:6 ans:24 a1:2 a2:4
            vari1 <= 52;
            vari2 <= 54;
            ans1 <= 50;
            ans2 <= 52;
            state <= 2;
         end
         40:begin
            //num1:5 num2:6 ans:30 a1:3 a2:0
            vari1 <= 53;
            vari2 <= 54;
            ans1 <= 51;
            ans2 <= 48;
            state <= 2;
         end
         41:begin
            //num1:6 num2:6 ans:36 a1:3 a2:6
            vari1 <= 54;
            vari2 <= 54;
            ans1 <= 51;
            ans2 <= 54;
            state <= 2;
         end
         42:begin
            //num1:7 num2:6 ans:42 a1:4 a2:2
            vari1 <= 55;
            vari2 <= 54;
            ans1 <= 52;
            ans2 <= 50;
            state <= 2;
         end
         43:begin
            //num1:8 num2:6 ans:48 a1:4 a2:8
            vari1 <= 56;
            vari2 <= 54;
            ans1 <= 52;
            ans2 <= 56;
            state <= 2;
         end
         44:begin
            //num1:9 num2:6 ans:54 a1:5 a2:4
            vari1 <= 57;
            vari2 <= 54;
            ans1 <= 53;
            ans2 <= 52;
            state <= 2;
         end
         45:begin
            //num1:1 num2:7 ans:7 a1:7 a2:-48
            vari1 <= 49;
            vari2 <= 55;
            ans1 <= 55;
            ans2 <= 0;
            state <= 2;
         end
         46:begin
            //num1:2 num2:7 ans:14 a1:1 a2:4
            vari1 <= 50;
            vari2 <= 55;
            ans1 <= 49;
            ans2 <= 52;
            state <= 2;
         end
         47:begin
            //num1:3 num2:7 ans:21 a1:2 a2:1
            vari1 <= 51;
            vari2 <= 55;
            ans1 <= 50;
            ans2 <= 49;
            state <= 2;
         end
         48:begin
            //num1:4 num2:7 ans:28 a1:2 a2:8
            vari1 <= 52;
            vari2 <= 55;
            ans1 <= 50;
            ans2 <= 56;
            state <= 2;
         end
         49:begin
            //num1:5 num2:7 ans:35 a1:3 a2:5
            vari1 <= 53;
            vari2 <= 55;
            ans1 <= 51;
            ans2 <= 53;
            state <= 2;
         end
         50:begin
            //num1:6 num2:7 ans:42 a1:4 a2:2
            vari1 <= 54;
            vari2 <= 55;
            ans1 <= 52;
            ans2 <= 50;
            state <= 2;
         end
         51:begin
            //num1:7 num2:7 ans:49 a1:4 a2:9
            vari1 <= 55;
            vari2 <= 55;
            ans1 <= 52;
            ans2 <= 57;
            state <= 2;
         end
         52:begin
            //num1:8 num2:7 ans:56 a1:5 a2:6
            vari1 <= 56;
            vari2 <= 55;
            ans1 <= 53;
            ans2 <= 54;
            state <= 2;
         end
         53:begin
            //num1:9 num2:7 ans:63 a1:6 a2:3
            vari1 <= 57;
            vari2 <= 55;
            ans1 <= 54;
            ans2 <= 51;
            state <= 2;
         end
         54:begin
            //num1:1 num2:8 ans:8 a1:8 a2:-48
            vari1 <= 49;
            vari2 <= 56;
            ans1 <= 56;
            ans2 <= 0;
            state <= 2;
         end
         55:begin
            //num1:2 num2:8 ans:16 a1:1 a2:6
            vari1 <= 50;
            vari2 <= 56;
            ans1 <= 49;
            ans2 <= 54;
            state <= 2;
         end
         56:begin
            //num1:3 num2:8 ans:24 a1:2 a2:4
            vari1 <= 51;
            vari2 <= 56;
            ans1 <= 50;
            ans2 <= 52;
            state <= 2;
         end
         57:begin
            //num1:4 num2:8 ans:32 a1:3 a2:2
            vari1 <= 52;
            vari2 <= 56;
            ans1 <= 51;
            ans2 <= 50;
            state <= 2;
         end
         58:begin
            //num1:5 num2:8 ans:40 a1:4 a2:0
            vari1 <= 53;
            vari2 <= 56;
            ans1 <= 52;
            ans2 <= 48;
            state <= 2;
         end
         59:begin
            //num1:6 num2:8 ans:48 a1:4 a2:8
            vari1 <= 54;
            vari2 <= 56;
            ans1 <= 52;
            ans2 <= 56;
            state <= 2;
         end
         60:begin
            //num1:7 num2:8 ans:56 a1:5 a2:6
            vari1 <= 55;
            vari2 <= 56;
            ans1 <= 53;
            ans2 <= 54;
            state <= 2;
         end
         61:begin
            //num1:8 num2:8 ans:64 a1:6 a2:4
            vari1 <= 56;
            vari2 <= 56;
            ans1 <= 54;
            ans2 <= 52;
            state <= 2;
         end
         62:begin
            //num1:9 num2:8 ans:72 a1:7 a2:2
            vari1 <= 57;
            vari2 <= 56;
            ans1 <= 55;
            ans2 <= 50;
            state <= 2;
         end
         63:begin
            //num1:1 num2:9 ans:9 a1:9 a2:-48
            vari1 <= 49;
            vari2 <= 57;
            ans1 <= 57;
            ans2 <= 0;
            state <= 2;
         end
         64:begin
            //num1:2 num2:9 ans:18 a1:1 a2:8
            vari1 <= 50;
            vari2 <= 57;
            ans1 <= 49;
            ans2 <= 56;
            state <= 2;
         end
         65:begin
            //num1:3 num2:9 ans:27 a1:2 a2:7
            vari1 <= 51;
            vari2 <= 57;
            ans1 <= 50;
            ans2 <= 55;
            state <= 2;
         end
         66:begin
            //num1:4 num2:9 ans:36 a1:3 a2:6
            vari1 <= 52;
            vari2 <= 57;
            ans1 <= 51;
            ans2 <= 54;
            state <= 2;
         end
         67:begin
            //num1:5 num2:9 ans:45 a1:4 a2:5
            vari1 <= 53;
            vari2 <= 57;
            ans1 <= 52;
            ans2 <= 53;
            state <= 2;
         end
         68:begin
            //num1:6 num2:9 ans:54 a1:5 a2:4
            vari1 <= 54;
            vari2 <= 57;
            ans1 <= 53;
            ans2 <= 52;
            state <= 2;
         end
         69:begin
            //num1:7 num2:9 ans:63 a1:6 a2:3
            vari1 <= 55;
            vari2 <= 57;
            ans1 <= 54;
            ans2 <= 51;
            state <= 2;
         end
         70:begin
            //num1:8 num2:9 ans:72 a1:7 a2:2
            vari1 <= 56;
            vari2 <= 57;
            ans1 <= 55;
            ans2 <= 50;
            state <= 2;
         end
         71:begin
            //num1:9 num2:9 ans:81 a1:8 a2:1
            vari1 <= 57;
            vari2 <= 57;
            ans1 <= 56;
            ans2 <= 49;
            state <= 2;
         end
         default:
            state <= 39;
         endcase
         que <= que + 1;
      end
      39:begin
         tone <= 0;
         if (rst)
            state <= 0;
         else begin
         clear <= 1;
         state <= 40;
         end
      end
      40:begin//you win!
         clear <= 0;
         charval <= 89;//y
         state <= 41;
      end
      41:begin
         showchar <= 1;
         char_col <= 2;
         state <= 42;
      end
      42:begin
         showchar <= 0;
         charval <= 79;//o
         state <= 43;
      end
      43:begin
         showchar <= 1;
         char_col <= 3;
         state <= 44;
      end
      44:begin
         showchar <= 0;
         charval <= 85;//u
         state <= 45;
      end
      45:begin
         showchar <= 1;
         char_col <= 4;
         state <= 46;
      end
      46:begin
         showchar <= 0;
         charval <= 87;//w
         state <= 47;
      end
      47:begin
         showchar <= 1;
         char_col <= 6;
         state <= 48;
      end
      48:begin
         showchar <= 0;
         charval <= 73;//i
         state <= 49;
      end
      49:begin
         showchar <= 1;
         char_col <= 7;
         state <= 50;
      end
      50:begin
         showchar <= 0;
         charval <= 78;//n
         state <= 51;
      end
      51:begin
         showchar <= 1;
         char_col <= 8;
         state <= 52;
      end
      52:begin
         showchar <= 0;
         charval <= 33;//!
         state <= 53;
      end
      53:begin
         showchar <= 1;
         char_col <= 9;
         state <= 59;
      end
      59:begin
         showchar <= 0;
         if (count == 3)begin
            state <= 60;
            count <= 0;
            clear <= 1;
         end
         else
            count <= count + 1;
      end
      60:begin//show USU logo
         showchar <= 0;
         clear <= 0;
         bmp <= 0;
         showbmp <= 1;
         if (rst)
            state <= 0;
         else
            state <= 60;
      end
      default:
         state <= 0;
      endcase
      end
   end

   always @(*) begin
      case (keys)
      16'b0000000000000001:begin
         charin = 48;
      end
      16'b0000000000000010:begin
         charin = 49;
      end
      16'b0000000000000100:begin
         charin = 50;
      end
      16'b0000000000001000:begin
         charin = 51;
      end
      16'b0000000000010000:begin
         charin = 52;
      end
      16'b0000000000100000:begin
         charin = 53;
      end
      16'b0000000001000000:begin
         charin = 54;
      end
      16'b0000000010000000:begin
         charin = 55;
      end
      16'b0000000100000000:begin
         charin = 56;
      end
      16'b0000001000000000:begin
         charin = 57;
      end
      default:
         charin = 97;
      endcase
   end

endmodule//game
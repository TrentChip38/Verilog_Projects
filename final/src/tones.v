`timescale 1ns/1ps

module tones(
        input clk,
        input rst_n,
        input [7:0] volume,
        input [15:0] tone,
        output reg AIN,
        output reg GAIN,
        output reg SHUTDOWN_L
        //,output reg [9:0] N
    );
    wire sout;
    reg [9:0] N;

    pwm_audio PWM1 (
		   .clk(clk),
		   .rst_n(rst_n),
		   .volume(volume),
		   .N(N),
		   .sout(sout)
		   );

   initial begin
	 GAIN       <= 1;
	 SHUTDOWN_L <= 1;
	 AIN        <= 0;	 
    end

   //might need to be clk divided
   always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
	GAIN       <= 1;
	SHUTDOWN_L <= 1;
	AIN        <= 0;	 
    end
        else if (tone[0])begin
	       AIN <= sout;
           N <= 747;//c
        end
        else if (tone[1])begin
            AIN <= sout;
            N <= 665;//d
        end
        else if (tone[2])begin
            AIN <= sout;
            N <= 593;//e  to g  8'b00000100
        end
        else if (tone[3])begin
            AIN <= sout;
            N <= 528;//f# bad
        end
        else if (tone[4])begin
            AIN <= sout;
            N <= 498;//g
        end
        else if (tone[5])begin
            AIN <= sout;
            N <= 444;//a
        end
        else if (tone[6])begin
            AIN <= sout;
            N <= 395;//b
        end
        else if (tone[7])begin
            AIN <= sout;
            N <= 352;//c#
        end
        else if (tone[8])begin
            AIN <= sout;
            N <= 332;//d
        end
        else if (tone[9])begin
            AIN <= sout;
            N <= 300;
        end
        else if (tone[10])begin
            AIN <= sout;
            N <= 400;
        end
        else if (tone[11])begin
            AIN <= sout;
            N <= 600;
        end
        else if (tone[12])begin
            AIN <= sout;
            N <= 800;
        end
        else if (tone[13])begin
            AIN <= sout;
            N <= 900;
        end
        else if (tone[14])begin
            AIN <= sout;
            N <= 1000;
        end
        else if (tone[15])begin
            AIN <= sout;
            N <= 1023;
        end
        else
            AIN <= 0;
    end
endmodule
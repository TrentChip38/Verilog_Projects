`timescale 1ns/1ps
/*
module sound(
        input clk,
        input rst_n,
        input [2:0] noise,
        output AIN,
        output GAIN,
        output SHUTDOWN_L
    );
    wire sout;
    reg state [7:0] = 0;
    reg win = 1;
    reg start = 1;
    tones TONE(clk, rst_n, volume, tone, AIN, GAIN, SHUTDOWN_L);

//which noises will play
    always @(posedge clk) begin
        if (noise == 1)begin//lose
            state <= 1;
        end
        else if(noise == 2)begin//win
            state <= 3;
        end
        else if(noise == 3)begin//start game
            state <= 10;
        end
    end

//divide clk half second or so for audible short noise
    always @(posedge div_clk) begin
        //case statment for every step thorugh of each noise
        //case for playing bad tone half second
        //case for playing multiple each half second
    end

endmodule*/
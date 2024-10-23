`timescale 1ns / 1ps

module debouncer(
    input b,
    input clk,
    output reg d
    );
    integer clk_count = 0;
    reg [1:0]state;
    reg div_clk = 0;
    initial begin
        state = 0;
        d = 0;
    end
    always @(posedge div_clk)begin
    case (state)
        2'b00 : begin
        //waiting
        //d <= 0;
        if(b)
        state <= 1;
        end
        2'b01 : begin
        //pressed
        if(b)
            state <= 3;
        else
            state <= 0;
        //d <= 0;
        end
        2'b11 : begin
        //held
        if(!b)begin
            state <= 2;
        d <= ~d;
        end
        end
        2'b10 : begin
        //released, wait till it can be pressed again
        state <= 0;
        //d <= 0;
        end
    endcase
    end
    always @(posedge clk)begin
        if(clk_count == 5)begin
            div_clk <= ~div_clk;
            clk_count <= 0;
        end
        else
            clk_count <= clk_count + 1;
    end
endmodule
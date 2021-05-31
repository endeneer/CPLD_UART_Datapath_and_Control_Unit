`timescale  1ns/100ps

module UART_transmitter_with_peripheral_tb();
    parameter DATA_WIDTH=8;
    parameter BIT_COUNTER_WIDTH=3;
    parameter CLOCK_COUNTER_WIDTH=21;
    parameter CLOCKS_PER_BIT=434;
    parameter CLOCKS_FOR_STOP=1608997;

    reg r_clock;
    initial begin 
        r_clock = 1;
        forever begin
            #0.5 r_clock = ~r_clock;
        end 
    end

    reg r_resetL;
    reg r_key_a;
    reg r_key_s;
    reg r_key_d;
    reg r_key_w;

    wire w_TX;
    UART_transmitter_with_peripheral #(
        .DATA_WIDTH(DATA_WIDTH),
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .CLOCK_COUNTER_WIDTH(CLOCK_COUNTER_WIDTH),        
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT),
        .CLOCKS_FOR_STOP(CLOCKS_FOR_STOP)
    ) inst_UART_transmitter_with_peripheral(
        .i_clock(r_clock),
        .i_resetL(r_resetL),
        .i_key_a(r_key_a),
        .i_key_s(r_key_s),
        .i_key_d(r_key_d),
        .i_key_w(r_key_w),
        .o_TX(w_TX)
    );

    initial begin
        r_resetL=0; r_key_a=0; r_key_s=0; r_key_d=0; r_key_w=0; #(CLOCKS_PER_BIT * 2);
        r_resetL=1; #(CLOCKS_PER_BIT * 2);
        r_key_a=1; #(CLOCKS_PER_BIT * (DATA_WIDTH + 1) + CLOCKS_FOR_STOP);
        r_key_a=0; #(CLOCKS_PER_BIT * 2);
        r_key_w=0; #(CLOCKS_PER_BIT); $stop;
    end
endmodule
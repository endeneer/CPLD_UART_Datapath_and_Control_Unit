module UART_project(
    input i_clock,
    input i_resetL,
    input i_key_a,
    input i_key_s,
    input i_key_d,
    input i_key_w,
    input i_RX,
    output o_TX,
    output [13:0] o_segment_2_digits
);
    parameter RX_CLOCK_COUNTER_WIDTH=10;
    parameter TX_CLOCK_COUNTER_WIDTH=21;
    parameter BIT_COUNTER_WIDTH=3;
    parameter DATA_WIDTH=8;
    parameter CLOCKS_PER_BIT=434;
    parameter CLOCKS_FOR_STOP=1608997;

    UART_receiver_with_peripheral #(
        .CLOCK_COUNTER_WIDTH(RX_CLOCK_COUNTER_WIDTH),
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT)
    ) inst_UART_receiver_with_peripheral(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_RX(i_RX),
        .o_segment_2_digits(o_segment_2_digits)
    );

    UART_transmitter_with_peripheral #(
        .CLOCK_COUNTER_WIDTH(TX_CLOCK_COUNTER_WIDTH),
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT),
        .CLOCKS_FOR_STOP(CLOCKS_FOR_STOP)
    ) inst_UART_transmitter_with_peripheral(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_key_a(i_key_a),
        .i_key_s(i_key_s),
        .i_key_d(i_key_d),
        .i_key_w(i_key_w),
        .o_TX(o_TX)
    );
endmodule

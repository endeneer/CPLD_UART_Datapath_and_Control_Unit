module UART_transmitter_with_peripheral #(
    parameter DATA_WIDTH = 8,
    parameter BIT_COUNTER_WIDTH=3,
    parameter CLOCK_COUNTER_WIDTH=21,
    parameter CLOCKS_PER_BIT=434,
    parameter CLOCKS_FOR_STOP=1608997
)(
    input i_clock,
    input i_resetL,
    input i_key_a,
    input i_key_s,
    input i_key_d,
    input i_key_w,
    output o_TX
);
    wire [DATA_WIDTH-1:0] w_value;
    wire w_key_pressed;
    multiple_keypress_encoder #(
        .DATA_WIDTH(DATA_WIDTH)
    ) inst_keypress_encoder(
        .i_key_a(i_key_a),
        .i_key_s(i_key_s),
        .i_key_d(i_key_d),
        .i_key_w(i_key_w),
        .o_value(w_value),
        .o_key_pressed(w_key_pressed)
    );

    UART_transmitter #(
        .CLOCK_COUNTER_WIDTH(CLOCK_COUNTER_WIDTH),
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT),
        .CLOCKS_FOR_STOP(CLOCKS_FOR_STOP)
    ) inst_UART_transmitter(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_key_pressed(w_key_pressed),
        .i_value(w_value),
        .o_TX(o_TX)
    );
endmodule
module UART_transmitter #(
    parameter DATA_WIDTH = 8,
    parameter BIT_COUNTER_WIDTH=3,
    parameter CLOCK_COUNTER_WIDTH=21,
    parameter CLOCKS_PER_BIT=434,
    parameter CLOCKS_FOR_STOP=1608997
)(
    input i_clock,
    input i_resetL,
    input i_key_pressed,
    input [DATA_WIDTH-1:0] i_value,
    output o_TX
);
    wire w_state_is_START;
    wire w_state_is_DATA;
    wire w_state_is_STOP;
    wire w_equal;
    wire w_equal_MSB;

    transmitter_control inst_transmitter_control(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_key_pressed(i_key_pressed),
        .i_equal(w_equal),
        .i_equal_MSB(w_equal_MSB),
        .o_state_is_START(w_state_is_START),
        .o_state_is_DATA(w_state_is_DATA),
        .o_state_is_STOP(w_state_is_STOP)
    );

    transmitter_datapath #(
        .DATA_WIDTH(DATA_WIDTH),
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .CLOCK_COUNTER_WIDTH(CLOCK_COUNTER_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT),
        .CLOCKS_FOR_STOP(CLOCKS_FOR_STOP)
    )
    inst_transmitter_datapath(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_value(i_value),
        .i_state_is_START(w_state_is_START),
        .i_state_is_DATA(w_state_is_DATA),
        .i_state_is_STOP(w_state_is_STOP),
        .o_equal(w_equal),
        .o_equal_MSB(w_equal_MSB),
        .o_TX(o_TX)
    );
endmodule
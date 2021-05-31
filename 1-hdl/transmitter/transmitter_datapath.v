module transmitter_datapath #(
    parameter DATA_WIDTH = 8,
    parameter BIT_COUNTER_WIDTH=3,
    parameter CLOCK_COUNTER_WIDTH=21,
    parameter CLOCKS_PER_BIT=434,
    parameter CLOCKS_FOR_STOP=1608997
)(
    input i_clock,
    input i_resetL,
    input [DATA_WIDTH-1:0] i_value,
    //input i_state_is_IDLE,
    input i_state_is_START,
    input i_state_is_DATA,
    input i_state_is_STOP,
    output o_equal,
    output o_equal_MSB,
    output o_TX
);
    transmitter_shifter #(
        .DATA_WIDTH(DATA_WIDTH)
    ) inst_transmitter_shifter(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_value(i_value),
        .i_state_is_START(i_state_is_START),
        .i_state_is_DATA(i_state_is_DATA),
        .i_equal(o_equal),
        .o_TX(o_TX)
    );

    transmitter_bit_counter #(
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) inst_transmitter_bit_counter(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_state_is_START(i_state_is_START),
        .i_state_is_DATA(i_state_is_DATA),
        .i_equal(o_equal),
        .o_equal_MSB(o_equal_MSB)
    );

    transmitter_clock_counter #(
        .CLOCK_COUNTER_WIDTH(CLOCK_COUNTER_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT),
        .CLOCKS_FOR_STOP(CLOCKS_FOR_STOP)
    ) inst_transmitter_clock_counter(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_state_is_START(i_state_is_START),
        .i_state_is_DATA(i_state_is_DATA),
        .i_state_is_STOP(i_state_is_STOP),
        .o_equal(o_equal)
    );
endmodule
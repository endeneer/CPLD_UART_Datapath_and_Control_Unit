module receiver_datapath #(
    parameter CLOCK_COUNTER_WIDTH=10,
    parameter BIT_COUNTER_WIDTH=3,
    parameter DATA_WIDTH=8,
    parameter CLOCKS_PER_BIT=434
)(
    input                   i_clock,
    input                   i_resetL,
    input                   i_RX,
    input                   i_state_is_START,
    input                   i_state_is_DATA,
    input                   i_state_is_STOP,
    output                  o_equal,
    output                  o_equal_MSB,
    output [DATA_WIDTH-1:0] o_received_data
);
    receiver_shifter #(
        .CLOCK_COUNTER_WIDTH(CLOCK_COUNTER_WIDTH),
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT)
    ) inst_receiver_shifter(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_RX(i_RX),
        .i_state_is_DATA(i_state_is_DATA),
        .i_state_is_STOP(i_state_is_STOP),
        .i_equal(o_equal),
        .o_received_data(o_received_data)
    );
    
    receiver_bit_counter #(
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) inst_receiver_bit_counter(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_state_is_START(i_state_is_START),
        .i_state_is_DATA(i_state_is_DATA),
        .i_equal(o_equal),
        .o_equal_MSB(o_equal_MSB)
    );

    receiver_clock_counter #(
        .CLOCK_COUNTER_WIDTH(CLOCK_COUNTER_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT)
    ) inst_receiver_clock_counter(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_state_is_START(i_state_is_START),
        .i_state_is_DATA(i_state_is_DATA),
        .i_state_is_STOP(i_state_is_STOP),
        .o_equal(o_equal)
    );

endmodule
module transmitter_bit_counter #(
    parameter BIT_COUNTER_WIDTH=3,
    parameter DATA_WIDTH=8 
)(
    input i_clock,
    input i_resetL,
    input i_state_is_START,
    input i_state_is_DATA,
    input i_equal,
    output o_equal_MSB
);
    wire w_equal_delayed_one_cycle;
    one_cycle_delayer inst_one_cycle_delayer_for_equal(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_to_be_delayed_one_cycle(i_equal),
        .o_delayed_one_cycle(w_equal_delayed_one_cycle)
    );

    wire [BIT_COUNTER_WIDTH-1:0] w_adder;
    wire [BIT_COUNTER_WIDTH-1:0] w_bit_index;
    wire w_resetL;
    flip_flop_async_reset #(
        .WIDTH(BIT_COUNTER_WIDTH)
    ) inst_flip_flop_async_reset(
        .i_clock(w_equal_delayed_one_cycle),
        .i_async_resetL(w_resetL),
        .i_d(w_adder),
        .o_q(w_bit_index)
    );

    localparam [BIT_COUNTER_WIDTH-1:0] lp_DATA_WIDTH_minus_one = DATA_WIDTH-1;
    equal_comparator #(
        .WIDTH(BIT_COUNTER_WIDTH)
    ) inst_equal_comparator(
        .i_a(w_bit_index),
        .i_b(lp_DATA_WIDTH_minus_one),
        .o_c(o_equal_MSB)
    );

    localparam [BIT_COUNTER_WIDTH-1:0] lp_one  = 1;
    adder #(
        .WIDTH(BIT_COUNTER_WIDTH)
    ) inst_adder(
        .i_a(w_bit_index),
        .i_b(lp_one),
        .o_y(w_adder)
    );

    wire w_state_is_START_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_START(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_state_is_START),
        .o_delayed_half_cycle(w_state_is_START_delayed_half_cycle)
    );
    assign w_resetL = i_resetL & (~w_state_is_START_delayed_half_cycle & i_state_is_DATA);
endmodule
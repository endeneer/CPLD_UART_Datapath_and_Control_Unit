module transmitter_clock_counter #(
    parameter CLOCK_COUNTER_WIDTH=21,
    parameter CLOCKS_PER_BIT=434,
    parameter CLOCKS_FOR_STOP=1612903
)(
    input i_clock,
    input i_resetL,
    input i_state_is_START,
    input i_state_is_DATA,
    input i_state_is_STOP,
    output o_equal
);
    wire [CLOCK_COUNTER_WIDTH-1:0] w_adder;
    wire [CLOCK_COUNTER_WIDTH-1:0] w_clock_count;
    wire w_resetL;
    flip_flop_sync_reset #(
        .WIDTH(CLOCK_COUNTER_WIDTH)
    ) inst_flip_flop_sync_reset(
        .i_clock(i_clock),
        .i_sync_resetL(w_resetL),
        .i_d(w_adder),
        .o_q(w_clock_count)
    );

    localparam [CLOCK_COUNTER_WIDTH-1:0] lp_one  = 1;
    adder #(
        .WIDTH(CLOCK_COUNTER_WIDTH)
    ) inst_adder(
        .i_a(w_clock_count),
        .i_b(lp_one),
        .o_y(w_adder)
    );

    wire w_equal_CLOCKS_PER_BIT_minus_one;
    localparam [CLOCK_COUNTER_WIDTH-1:0] lp_CLOCKS_PER_BIT_minus_one = CLOCKS_PER_BIT-1;
    equal_comparator #(
        .WIDTH(CLOCK_COUNTER_WIDTH)
    ) inst_equal_comparator_for_CLOCKS_PER_BIT_minus_one(
        .i_a(w_clock_count),
        .i_b(lp_CLOCKS_PER_BIT_minus_one),
        .o_c(w_equal_CLOCKS_PER_BIT_minus_one)
    );

    wire w_equal_CLOCKS_FOR_STOP_minus_one;
    localparam [CLOCK_COUNTER_WIDTH-1:0] lp_CLOCKS_FOR_STOP_minus_one = CLOCKS_FOR_STOP-1;
    equal_comparator #(
        .WIDTH(CLOCK_COUNTER_WIDTH)
    ) inst_equal_comparator_for_CLOCKS_FOR_STOP_minus_one(
        .i_a(w_clock_count),
        .i_b(lp_CLOCKS_FOR_STOP_minus_one),
        .o_c(w_equal_CLOCKS_FOR_STOP_minus_one)
    );

    mux2 #(
        .WIDTH(1)
    ) inst_mux2_for_equal(
        .i_d0(w_equal_CLOCKS_PER_BIT_minus_one),
        .i_d1(w_equal_CLOCKS_FOR_STOP_minus_one),
        .i_s(i_state_is_STOP),
        .o_y(o_equal)
    );

    wire w_equal_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_equal(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(o_equal),
        .o_delayed_half_cycle(w_equal_delayed_half_cycle)
    );

    wire w_state_is_START_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_START(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_state_is_START),
        .o_delayed_half_cycle(w_state_is_START_delayed_half_cycle)
    );

    assign w_resetL = i_resetL &
                      ~w_equal_delayed_half_cycle &
                      (w_state_is_START_delayed_half_cycle | i_state_is_DATA | i_state_is_STOP);
endmodule
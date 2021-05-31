module receiver_shifter #(
    parameter CLOCK_COUNTER_WIDTH=10,
    parameter BIT_COUNTER_WIDTH=3,
    parameter DATA_WIDTH=8,
    parameter CLOCKS_PER_BIT=434
)(
    input i_clock,
    input i_resetL,
    input i_RX,
    input i_state_is_DATA,
    input i_state_is_STOP,
    input i_equal,
    output [DATA_WIDTH-1:0] o_received_data
);
    wire w_equal_delayed_one_cycle;
    one_cycle_delayer inst_one_cycle_delayer_for_equal(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_to_be_delayed_one_cycle(i_equal),
        .o_delayed_one_cycle(w_equal_delayed_one_cycle)
    );

    wire w_state_is_DATA_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_DATA(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_state_is_DATA),
        .o_delayed_half_cycle(w_state_is_DATA_delayed_half_cycle)
    );

    wire [DATA_WIDTH-1:0] w_parallel_shift_out;
    right_shift_register #(
        .WIDTH(DATA_WIDTH)
    ) inst_right_shift_register(
        .i_clock(w_equal_delayed_one_cycle),
        .i_async_resetL(i_resetL),
        .i_shift_enL(~w_state_is_DATA_delayed_half_cycle),
        .i_shift_in(i_RX),
        .o_parallel_shift_out(w_parallel_shift_out)
    );

    wire w_state_is_STOP_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_STOP(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_state_is_STOP),
        .o_delayed_half_cycle(w_state_is_STOP_delayed_half_cycle)
    );

    flip_flop_async_reset #(
        .WIDTH(DATA_WIDTH)
    ) inst_register(
        .i_clock(w_state_is_STOP_delayed_half_cycle),
        .i_async_resetL(i_resetL),
        .i_d(w_parallel_shift_out),
        .o_q(o_received_data)
    );
endmodule
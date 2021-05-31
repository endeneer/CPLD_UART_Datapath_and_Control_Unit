module transmitter_shifter #(
    parameter  DATA_WIDTH = 8
)(
    input i_clock,
    input i_resetL,
    input [DATA_WIDTH-1:0] i_value,
    input i_state_is_START,
    input i_state_is_DATA,
    input i_equal,
    output o_TX
);
    wire w_state_is_START_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_START(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_state_is_START),
        .o_delayed_half_cycle(w_state_is_START_delayed_half_cycle)
    );

    wire w_state_is_DATA_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_DATA(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_state_is_DATA),
        .o_delayed_half_cycle(w_state_is_DATA_delayed_half_cycle)
    );

    wire w_equal_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_equal(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_equal),
        .o_delayed_half_cycle(w_equal_delayed_half_cycle)
    );

    wire w_state_is_START_pulse;
    low_to_high_detector inst_low_to_high_detector(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_level(i_state_is_START),
        .o_pulse(w_state_is_START_pulse)
    );

    wire w_equal_delayed_one_cycle;
    one_cycle_delayer inst_one_cycle_delayer_for_equal(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_to_be_delayed_one_cycle(i_equal),
        .o_delayed_one_cycle(w_equal_delayed_one_cycle)
    );

    wire w_state_is_START_pulse_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_START_pulse(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(w_state_is_START_pulse),
        .o_delayed_half_cycle(w_state_is_START_pulse_delayed_half_cycle)
    );

    wire w_clock = w_state_is_START_pulse_delayed_half_cycle | w_equal_delayed_one_cycle;
    wire w_shift_en = w_state_is_DATA_delayed_half_cycle;
    wire w_shift_out;
    transmitter_shift_register #(
        .DATA_WIDTH(DATA_WIDTH)
    ) inst_transmitter_shift_register(
        .i_clock(w_clock),
        .i_async_resetL(i_resetL),
        .i_shift_en(w_shift_en),
        .i_ld_en(w_state_is_START_pulse),
        .i_load(i_value),
        .o_shift_out(w_shift_out)
    );

    localparam [0:0] lp_one  = 1;
    localparam [0:0] lp_zero = 0;
    wire w_mux_stage1;
    mux2 #(
        .WIDTH(1)
    ) inst_mux2_stage1(
        .i_d0(lp_one),
        .i_d1(lp_zero),
        .i_s(i_state_is_START),
        .o_y(w_mux_stage1)
    );

    mux2 #(
        .WIDTH(1)
    ) inst_mux2_stage2(
        .i_d0(w_mux_stage1),
        .i_d1(w_shift_out),
        .i_s(i_state_is_DATA),
        .o_y(o_TX)
    );

endmodule
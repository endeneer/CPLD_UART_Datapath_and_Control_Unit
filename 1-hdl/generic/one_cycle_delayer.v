module one_cycle_delayer(
    input i_clock,
    input i_resetL,
    input i_to_be_delayed_one_cycle,
    output o_delayed_one_cycle
);
    wire w_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_to_be_delayed_one_cycle),
        .o_delayed_half_cycle(w_delayed_half_cycle)
    );

    flip_flop_async_reset #(
        .WIDTH(1)
    ) inst_flip_flop_async_reset(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_d(w_delayed_half_cycle),
        .o_q(o_delayed_one_cycle)
    );
endmodule
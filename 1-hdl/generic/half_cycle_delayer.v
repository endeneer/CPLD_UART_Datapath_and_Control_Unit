module half_cycle_delayer(
    input i_clock,
    input i_async_resetL,
    input i_to_be_delayed_half_cycle,
    output reg o_delayed_half_cycle
);
    always @(negedge i_clock or negedge i_async_resetL) begin
        if (~i_async_resetL) o_delayed_half_cycle <= 0;
        else o_delayed_half_cycle <= i_to_be_delayed_half_cycle;
    end
endmodule
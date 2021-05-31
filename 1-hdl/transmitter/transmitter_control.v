module transmitter_control(
    input  i_clock,
    input  i_resetL,
    input  i_key_pressed,
    input  i_equal,
    input  i_equal_MSB,
    output o_state_is_START,
    output o_state_is_DATA,
    output o_state_is_STOP 
);
    localparam [1:0]
        IDLE = 2'b00,
        START = 2'b01,
        DATA = 2'b10,
        STOP = 2'b11;

    reg[1:0] r_current_state, r_next_state;

    wire w_equal_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_equal(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_equal),
        .o_delayed_half_cycle(w_equal_delayed_half_cycle)
    );
    wire w_equal_MSB_delayed_half_cycle;
    half_cycle_delayer inst_half_cycle_delayer_for_equal_MSB(
        .i_clock(i_clock),
        .i_async_resetL(i_resetL),
        .i_to_be_delayed_half_cycle(i_equal_MSB),
        .o_delayed_half_cycle(w_equal_MSB_delayed_half_cycle)
    );

    always @(r_current_state, i_key_pressed, 
             w_equal_delayed_half_cycle, 
             w_equal_MSB_delayed_half_cycle) begin
        r_next_state = r_current_state;
        case(r_current_state)
            IDLE:
                if (~i_key_pressed) r_next_state <= IDLE;
                else if (i_key_pressed) r_next_state <= START;
            START:
                if (~w_equal_delayed_half_cycle) r_next_state <= START;
                else if (w_equal_delayed_half_cycle) r_next_state <= DATA;
            DATA:
                if (w_equal_delayed_half_cycle & ~w_equal_MSB_delayed_half_cycle) r_next_state <= DATA;
                else if (w_equal_delayed_half_cycle & w_equal_MSB_delayed_half_cycle) r_next_state <= STOP;
            STOP:
                if (~w_equal_delayed_half_cycle) r_next_state <= STOP;
                else if (w_equal_delayed_half_cycle & i_key_pressed) r_next_state <= START;
                else if (w_equal_delayed_half_cycle & ~i_key_pressed) r_next_state <= IDLE;
        endcase
    end

    always @(posedge i_clock, negedge i_resetL)
        if (~i_resetL) r_current_state <= IDLE;
        else r_current_state <= r_next_state;

    assign o_state_is_START = (r_current_state == START);
    assign o_state_is_DATA = (r_current_state == DATA);
    assign o_state_is_STOP = (r_current_state == STOP);
endmodule
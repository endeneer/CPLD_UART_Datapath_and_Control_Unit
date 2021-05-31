module low_to_high_detector(
    input i_clock,
    input i_resetL,
    input i_level,
    output o_pulse
);
    localparam [1:0]
        STATEZERO= 2'b00,
        STATEONE = 2'b01,
        STATETHREE=2'b10;

    reg[1:0] r_current_state, r_next_state;
    initial begin
        r_current_state <= STATEZERO;
        r_next_state <= STATEZERO;
    end

    always @(r_current_state, i_level) begin
        r_next_state = r_current_state;
        case(r_current_state)
            STATEZERO:
                if (i_level) r_next_state <= STATEONE;
            STATEONE:
                r_next_state <= STATETHREE;
            STATETHREE:
                if (~i_level) r_next_state <= STATEZERO;
        endcase
    end
    
    always @(posedge i_clock, negedge i_resetL)
        if (~i_resetL) r_current_state <= STATEZERO;
        else r_current_state <= r_next_state;

    assign o_pulse = (r_current_state == STATEONE);
endmodule
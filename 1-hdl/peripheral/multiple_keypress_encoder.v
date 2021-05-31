module multiple_keypress_encoder #(
    parameter  DATA_WIDTH=8
)(
    input i_key_a,
    input i_key_s,
    input i_key_d,
    input i_key_w,
    output reg [DATA_WIDTH-1:0] o_value,
    output o_key_pressed
);
    localparam [DATA_WIDTH-1:0] lp_a_value = 'h61;
    localparam [DATA_WIDTH-1:0] lp_s_value = 'h73;
    localparam [DATA_WIDTH-1:0] lp_d_value = 'h64;
    localparam [DATA_WIDTH-1:0] lp_w_value = 'h77;

    localparam [DATA_WIDTH-1:0] lp_wa_value = 'h23; //#
    localparam [DATA_WIDTH-1:0] lp_wd_value = 'h24; //$
    localparam [DATA_WIDTH-1:0] lp_sa_value = 'h25; //%
    localparam [DATA_WIDTH-1:0] lp_sd_value = 'h26; //&

    always @(i_key_a, i_key_s, i_key_d, i_key_w)
        case({i_key_a, i_key_s, i_key_d, i_key_w})
            4'b0000: o_value <= 0; //null
            4'b1000: o_value <= lp_a_value;
            4'b0100: o_value <= lp_s_value;
            4'b0010: o_value <= lp_d_value;
            4'b0001: o_value <= lp_w_value;
            4'b1001: o_value <= lp_wa_value;
            4'b0011: o_value <= lp_wd_value;
            4'b1100: o_value <= lp_sa_value;
            4'b0110: o_value <= lp_sd_value;
            default: o_value <= 0; //null
        endcase

    assign o_key_pressed = i_key_a | i_key_s | i_key_d | i_key_w;
endmodule
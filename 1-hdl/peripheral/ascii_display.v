module ascii_display(
    input [7:0] i_hex_2_digits,
    output [13:0] o_segment_2_digits
);
    hex_display inst_hex_display_digit0(
        .i_hex(i_hex_2_digits[3:0]),
        .o_segment(o_segment_2_digits[6:0])
    );

    hex_display inst_hex_display_digit1(
        .i_hex(i_hex_2_digits[7:4]),
        .o_segment(o_segment_2_digits[13:7])
    );
endmodule

module equal_comparator#(
    parameter WIDTH=8
)(
    input  [WIDTH-1:0] i_a, i_b,
    output             o_c
);
    assign o_c = (i_a == i_b);
endmodule

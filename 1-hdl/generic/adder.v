module adder #(
    parameter WIDTH=8
)(
    input  [WIDTH-1:0] i_a, i_b,
    output [WIDTH-1:0] o_y
);
    assign o_y = i_a + i_b;
endmodule

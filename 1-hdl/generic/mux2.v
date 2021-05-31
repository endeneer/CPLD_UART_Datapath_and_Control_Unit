module mux2 #(
    parameter  WIDTH=1
)(
    input [WIDTH-1:0] i_d0, i_d1, 
    input  i_s,
    output [WIDTH-1:0] o_y
);
    assign o_y = i_s ? i_d1 : i_d0;
endmodule

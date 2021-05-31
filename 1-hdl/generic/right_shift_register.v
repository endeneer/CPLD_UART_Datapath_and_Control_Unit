module right_shift_register #(
    parameter WIDTH=8
)(
    input                  i_clock,
    input                  i_async_resetL,
    input                  i_shift_enL,
    input                  i_shift_in,
    output reg [WIDTH-1:0] o_parallel_shift_out
);
    always @(posedge i_clock or negedge i_async_resetL) begin
        if (~i_async_resetL) o_parallel_shift_out <= 0;
        else if (~i_shift_enL) o_parallel_shift_out <= {i_shift_in, o_parallel_shift_out[WIDTH-1:1]};
    end
endmodule

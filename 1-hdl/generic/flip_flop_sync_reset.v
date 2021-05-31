module flip_flop_sync_reset #(
    parameter WIDTH=8
)(
    input                  i_clock,
    input                  i_sync_resetL,
    input      [WIDTH-1:0] i_d,
    output reg [WIDTH-1:0] o_q
);
    always @(posedge i_clock) begin
        if (~i_sync_resetL) o_q <= 0;
        else o_q <= i_d;
    end
endmodule
module transmitter_shift_register #(
    parameter  DATA_WIDTH = 8
)(
    input i_clock,
    input i_async_resetL,
    input i_shift_en,
    input i_ld_en,
    input [DATA_WIDTH-1:0] i_load,
    output o_shift_out
);
    reg [DATA_WIDTH-1:0] r_internal_load = 0;

    always @(posedge i_clock or negedge i_async_resetL) begin
        r_internal_load = r_internal_load;
        if (~i_async_resetL) r_internal_load <= 0;
        else if (i_ld_en) r_internal_load <= i_load;
        else if (i_shift_en) r_internal_load <= {r_internal_load[0], r_internal_load[DATA_WIDTH-1:1]};
    end

    assign o_shift_out = r_internal_load[0];
endmodule
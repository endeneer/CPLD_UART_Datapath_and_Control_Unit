module UART_receiver_with_peripheral #(
    parameter CLOCK_COUNTER_WIDTH=10,
    parameter BIT_COUNTER_WIDTH=3,
    parameter DATA_WIDTH=8,
    parameter CLOCKS_PER_BIT=434
)(
    input                   i_clock,
    input                   i_resetL,
    input                   i_RX,
    output [13:0] o_segment_2_digits
);
    wire [DATA_WIDTH-1:0] w_received_data;
    UART_receiver #(
        .CLOCK_COUNTER_WIDTH(CLOCK_COUNTER_WIDTH),
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT)
    ) inst_UART_receiver(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_RX(i_RX),
        .o_received_data(w_received_data)
    );

    ascii_display inst_ascii_display(
        .i_hex_2_digits(w_received_data),
        .o_segment_2_digits(o_segment_2_digits)
    );
endmodule
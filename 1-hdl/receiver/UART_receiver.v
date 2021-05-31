module UART_receiver #(
    parameter CLOCK_COUNTER_WIDTH=10,
    parameter BIT_COUNTER_WIDTH=3,
    parameter DATA_WIDTH=8,
    parameter CLOCKS_PER_BIT=434
)(
    input                   i_clock,
    input                   i_resetL,
    input                   i_RX,
    output [DATA_WIDTH-1:0] o_received_data
); 
    wire w_equal;
    wire w_equal_MSB;
    wire w_state_is_START;
    wire w_state_is_DATA;
    wire w_state_is_STOP;
   
    receiver_control inst_receiver_control(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_RX(i_RX),
        .i_equal(w_equal),
        .i_equal_MSB(w_equal_MSB),
        .o_state_is_START(w_state_is_START),
        .o_state_is_DATA(w_state_is_DATA),
        .o_state_is_STOP(w_state_is_STOP)
    );

    receiver_datapath #(
        .CLOCK_COUNTER_WIDTH(CLOCK_COUNTER_WIDTH),
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT)
    ) inst_receiver_datapath(
        .i_clock(i_clock),
        .i_resetL(i_resetL),
        .i_RX(i_RX),
        .i_state_is_START(w_state_is_START),
        .i_state_is_DATA(w_state_is_DATA),
        .i_state_is_STOP(w_state_is_STOP),
        .o_equal(w_equal),
        .o_equal_MSB(w_equal_MSB),
        .o_received_data(o_received_data)
    );

endmodule

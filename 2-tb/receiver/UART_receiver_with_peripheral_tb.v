`timescale  1ns/1ps

module UART_receiver_with_peripheral_tb();
    parameter CLOCK_COUNTER_WIDTH=10;
    parameter BIT_COUNTER_WIDTH=3;
    parameter DATA_WIDTH=8;
    parameter CLOCKS_PER_BIT=434;

    reg r_clock;
    reg r_resetL;
    reg r_RX;
    wire [13:0] w_segment_2_digits;

    UART_receiver_with_peripheral #(
        .CLOCK_COUNTER_WIDTH(CLOCK_COUNTER_WIDTH),
        .BIT_COUNTER_WIDTH(BIT_COUNTER_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .CLOCKS_PER_BIT(CLOCKS_PER_BIT)
    ) dut_UART_receiver_with_peripheral(
        .i_clock(r_clock),
        .i_resetL(r_resetL),
        .i_RX(r_RX),
        .o_segment_2_digits(w_segment_2_digits)
    );

    initial begin 
        r_clock = 1;
        forever begin
            #0.5 r_clock = ~r_clock;
        end 
    end

    task UART_WRITE_BYTE;
        input [7:0] i_Data;
        integer     int_index;
        begin
        
        // Send Start Bit
        r_RX <= 1'b0;
        #(CLOCKS_PER_BIT);
        
        // Send Data Byte
        for (int_index=0; int_index<8; int_index=int_index+1)
            begin
            r_RX <= i_Data[int_index];
            #(CLOCKS_PER_BIT);
            end
        int_index = 1; // not important, just a marker with duration CLOCKS_PER_BIT

        // Send Stop Bit
        r_RX <= 1'b1;
        #(CLOCKS_PER_BIT);
        int_index = 0; // not important, just a marker with duration CLOCKS_PER_BIT
        end
    endtask

  initial begin
      r_resetL = 0; r_RX = 1; #(CLOCKS_PER_BIT*2);
      r_resetL = 1; #1;
      UART_WRITE_BYTE(8'h61);
      #(CLOCKS_PER_BIT*2); $stop;
  end
endmodule

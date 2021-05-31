onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_receiver_with_peripheral_tb/UART_WRITE_BYTE/i_Data
add wave -noupdate /UART_receiver_with_peripheral_tb/UART_WRITE_BYTE/int_index
add wave -noupdate /UART_receiver_with_peripheral_tb/r_resetL
add wave -noupdate /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_UART_receiver/inst_receiver_datapath/inst_receiver_shifter/i_RX
add wave -noupdate /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_UART_receiver/i_clock
add wave -noupdate -radix unsigned /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_UART_receiver/inst_receiver_datapath/inst_receiver_clock_counter/w_clock_count
add wave -noupdate /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_UART_receiver/inst_receiver_datapath/inst_receiver_clock_counter/o_equal
add wave -noupdate -radix unsigned /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_UART_receiver/inst_receiver_datapath/inst_receiver_bit_counter/w_bit_index
add wave -noupdate /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_UART_receiver/inst_receiver_datapath/inst_receiver_bit_counter/o_equal_MSB
add wave -noupdate /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_UART_receiver/inst_receiver_control/r_current_state
add wave -noupdate -radix binary /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_UART_receiver/o_received_data
add wave -noupdate /UART_receiver_with_peripheral_tb/w_segment_2_digits
add wave -noupdate -radix binary /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_ascii_display/inst_hex_display_digit1/o_segment
add wave -noupdate /UART_receiver_with_peripheral_tb/dut_UART_receiver_with_peripheral/inst_ascii_display/inst_hex_display_digit0/o_segment
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 513
configure wave -valuecolwidth 135
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {6380850 ps}

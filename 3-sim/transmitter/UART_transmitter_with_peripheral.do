onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/i_key_a
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/i_key_s
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/i_key_d
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/i_key_w
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/inst_keypress_encoder/o_value
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/i_resetL
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/o_TX
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/i_clock
add wave -noupdate -radix unsigned /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/inst_UART_transmitter/inst_transmitter_datapath/inst_transmitter_clock_counter/w_clock_count
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/inst_UART_transmitter/inst_transmitter_datapath/inst_transmitter_clock_counter/o_equal
add wave -noupdate -radix unsigned /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/inst_UART_transmitter/inst_transmitter_datapath/inst_transmitter_bit_counter/w_bit_index
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/inst_UART_transmitter/inst_transmitter_datapath/inst_transmitter_bit_counter/o_equal_MSB
add wave -noupdate /UART_transmitter_with_peripheral_tb/inst_UART_transmitter_with_peripheral/inst_UART_transmitter/inst_transmitter_control/r_current_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 335
configure wave -valuecolwidth 100
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
WaveRestoreZoom {1600570800 ps} {1616750 ns}

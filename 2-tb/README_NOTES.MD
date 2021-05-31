# Useful ModelSim/VSIM commands
## Simulate for the first time
Note: WLF stands for wave log format
```
vsim -wlf <design>.wlf work.<design>_tb
run -all
quit -sim
```

## View the waveform without re-simulation
```
vsim -view <design>.wlf -do <design>.do
dataset close <design>
```

## Re-simulation using the same waveform configuration
```
vsim -wlf <design>.wlf -do <design>.do -do "run -all" work.<design>_tb
```

# UART_receiver_with_peripheral
vsim -wlf UART_receiver_with_peripheral.wlf work.UART_receiver_with_peripheral_tb

vsim -wlf UART_receiver_with_peripheral.wlf -do UART_receiver_with_peripheral.do -do "run -all" work.UART_receiver_with_peripheral_tb

# UART_transmitter_with_peripheral
vsim -wlf UART_transmitter_with_peripheral.wlf work.UART_transmitter_with_peripheral_tb

vsim -wlf UART_transmitter_with_peripheral.wlf -do UART_transmitter_with_peripheral.do -do "run -all" work.UART_transmitter_with_peripheral_tb

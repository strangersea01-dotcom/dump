set_units -time 1250.0ps
set_units -capacitance 1000.0fF

current_design riscv_scalar_cryptography_proscessor 

create_clock  -name clk -period 1 -waveform {0 0.5} [get_ports clk]
create_clock -name vclk -period  1  -waveform {0 0.5}

set_clock_uncertainty -setup 0.2 [get_clocks clk]
set_clock_uncertainty -hold  0.1 [get_clocks clk]

set_input_delay -clock vclk 0.4  -max [get_ports [remove_from_collection [all_inputs] {clk}]]
set_input_delay -clock vclk 0.1  -min [get_ports [remove_from_collection [all_inputs] {clk}]]

set_output_delay -clock vclk 0.5 -max -add_delay [get_ports [all_outputs]]
set_output_delay -clock vclk 0.2 -min -add_delay [get_ports [all_outputs]]

set_driving_cell -lib_cell BUFX4 [get_ports [remove_from_collection [all_inputs] {clk } ]]
set_load -max 0.1  [get_ports [all_outputs]]

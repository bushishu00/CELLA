
set period_clk  2.5

set_max_transition 0.75 [current_design]

set_fanout_load 0.125 [all_outputs]
set_load 1.25 [all_outputs]

create_clock -name clk_inv -period $period_clk -waveform [list [expr $period_clk/2] $period_clk] [get_ports clk_inv]

set_clock_uncertainty 0.05  [get_clocks clk_inv]



set max_input_delay  [expr $period_clk * 0.5]
set min_input_delay  [expr $period_clk * 0.2]
# set all input ports
set_input_delay -clock clk_inv  -max $max_input_delay  [get_ports Din]
set_input_delay -clock clk_inv  -min $min_input_delay  [get_ports Din]

#set all output ports
set max_output_delay  [expr $period_clk * 0.5]
set min_output_delay  [expr $period_clk * 0.05]
set_output_delay -clock clk_inv  -max $max_output_delay  [get_ports Q]
set_output_delay -clock clk_inv  -min $min_output_delay  [get_ports Q]


set_input_transition 0.625 [all_inputs]

set_timing_derate  -data  -late 1.336




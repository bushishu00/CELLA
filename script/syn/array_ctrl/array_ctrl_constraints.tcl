
set period_clk  2.5

set_max_transition 0.75 [current_design]

set_fanout_load 0.125 [all_outputs]
set_load 1.25 [all_outputs]

create_clock -name clk -period $period_clk [get_ports clk]
create_clock -name clk_inv -period $period_clk -waveform [list [expr $period_clk/2] $period_clk] [get_ports clk_inv]

set_clock_uncertainty 0.05  [get_clocks clk]

group_path -name clk_to_clk         -from [get_clocks clk]  -to [get_clocks clk]
group_path -name clk_to_clk_inv     -from [get_clocks clk]  -to [get_clocks clk_inv]
group_path -name clk_inv_to_clk     -from [get_clocks clk_inv]  -to [get_clocks clk]
group_path -name clk_inv_to_clk_inv -from [get_clocks clk_inv]  -to [get_clocks clk_inv]

set max_input_delay  [expr $period_clk * 0.5]
set min_input_delay  [expr $period_clk * 0.2]
# set all input ports
set_input_delay -clock clk  -max $max_input_delay  [get_ports rst_n]
set_input_delay -clock clk  -min $min_input_delay  [get_ports rst_n]
set_input_delay -clock clk_inv  -max $max_input_delay  [get_ports rst_n]
set_input_delay -clock clk_inv  -min $min_input_delay  [get_ports rst_n]
set_input_delay -clock clk  -max $max_input_delay  [get_ports op_code]
set_input_delay -clock clk  -min $min_input_delay  [get_ports op_code]
set_input_delay -clock clk  -max $max_input_delay  [get_ports addr]
set_input_delay -clock clk  -min $min_input_delay  [get_ports addr]
set_input_delay -clock clk  -max $max_input_delay  [get_ports data_bank]
set_input_delay -clock clk  -min $min_input_delay  [get_ports data_bank]
set_input_delay -clock clk  -max $max_input_delay  [get_ports data_in]
set_input_delay -clock clk  -min $min_input_delay  [get_ports data_in]

#set all output ports
set max_output_delay  [expr $period_clk * 0.5]
set min_output_delay  [expr $period_clk * 0.05]
set_output_delay -clock clk  -max $max_output_delay  [get_ports mac_en]
set_output_delay -clock clk  -min $min_output_delay  [get_ports mac_en]
set_output_delay -clock clk  -max $max_output_delay  [get_ports data_op]
set_output_delay -clock clk  -min $min_output_delay  [get_ports data_op]
set_output_delay -clock clk  -max $max_output_delay  [get_ports bank_mux]
set_output_delay -clock clk  -min $min_output_delay  [get_ports bank_mux]
set_output_delay -clock clk  -max $max_output_delay  [get_ports addr_row]
set_output_delay -clock clk  -min $min_output_delay  [get_ports addr_row]
set_output_delay -clock clk  -max $max_output_delay  [get_ports w_en]
set_output_delay -clock clk  -min $min_output_delay  [get_ports w_en]
set_output_delay -clock clk  -max $max_output_delay  [get_ports data_and]
set_output_delay -clock clk  -min $min_output_delay  [get_ports data_and]
set_output_delay -clock clk  -max $max_output_delay  [get_ports col_mux]
set_output_delay -clock clk  -min $min_output_delay  [get_ports col_mux]
set_output_delay -clock clk  -max $max_output_delay  [get_ports query_bar]
set_output_delay -clock clk  -min $min_output_delay  [get_ports query_bar]

set_output_delay -clock clk  -min $max_output_delay  [get_ports clk_copy]
set_output_delay -clock clk  -min $min_output_delay  [get_ports clk_copy]
set_output_delay -clock clk_inv  -min $max_output_delay  [get_ports clk_copy]
set_output_delay -clock clk_inv  -min $min_output_delay  [get_ports clk_copy]


set_input_transition 0.625 [all_inputs]

set_timing_derate  -data  -late 1.336




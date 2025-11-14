
set period_clk  2.5

set_max_transition 0.75 [current_design]

set_fanout_load 0.125 [all_outputs]
set_load 1.25 [all_outputs]

create_clock -name clk -period $period_clk [get_ports clk]

set_clock_uncertainty 0.05  [get_clocks clk]

set max_input_delay  [expr $period_clk * 0.5]
set min_input_delay  [expr $period_clk * 0.2]
# set all input ports
set_input_delay -clock clk  -max $max_input_delay  [get_ports rst_n]
set_input_delay -clock clk  -min $min_input_delay  [get_ports rst_n]

set_input_delay -clock clk  -max $max_input_delay  [get_ports bank0]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank0]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank1]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank1]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank2]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank2]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank3]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank3]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank4]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank4]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank5]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank5]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank6]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank6]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank7]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank7]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank8]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank8]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank9]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank9]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank10]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank10]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank11]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank11]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank12]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank12]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank13]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank13]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank14]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank14]
set_input_delay -clock clk  -max $max_input_delay  [get_ports bank15]
set_input_delay -clock clk  -min $min_input_delay  [get_ports bank15]


#set all output ports
set max_output_delay  [expr $period_clk * 0.5]
set min_output_delay  [expr $period_clk * 0.05]
set_output_delay -clock clk  -max $max_output_delay  [get_ports sum]
set_output_delay -clock clk  -min $min_output_delay  [get_ports sum]



set_input_transition 0.625 [all_inputs]

set_timing_derate  -data  -late 1.336



